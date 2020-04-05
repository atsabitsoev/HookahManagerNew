//
//  CreatingOrderModel.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import FirebaseFirestore


class CreatingOrderModel {
    
    
    private let db = Firestore.firestore()
    private var tableOrderedDatesDict: [String: [Date]] = [:]
    private var weekDaysDates: [Int: (startDate: Date, endDate: Date)] = [:]
    
    
    func fetchTables(_ handler: @escaping ([Table]?, String?) -> ()) {
        
        db.collection("restaurants").document("iX2jYDuiTxBpofOUHcvL").collection("tables").getDocuments { (querySnap, error) in
            guard let documents = querySnap?.documents else {
                handler(nil, error?.localizedDescription)
                print(error)
                return
            }
            
            let tables = documents.compactMap { (document) -> Table? in
                let docData = document.data()
                let tableId = document.documentID
                let sizeDict = docData["size"] as? [String: Any]
                guard let sizeId = sizeDict?["id"] as? String else { return nil }
                let sizeName = sizeDict?["name"] as? String
                let sizeCount = sizeDict?["maxCount"] as? Int
                let size = TableSize(id: sizeId, name: sizeName ?? "", count: sizeCount ?? 0)
                let options = docData["options"] as? [String]
                let table = Table(id: tableId, size: size, options: options ?? [])
                
                let datesTS = docData["orderedDates"] as? [Timestamp]
                let dates = datesTS?.map({ (timeStamp) -> Date in
                    return timeStamp.dateValue()
                }) ?? []
                let dictItem = (key: tableId, value: dates)
                self.tableOrderedDatesDict[dictItem.key] = dictItem.value
                
                let workDaysDict = docData["workDates"] as? [String: Any]
                if self.weekDaysDates.count < 7 {
                    self.configureWeekDaysDates(workDaysDict: workDaysDict)
                }
                
                return table
            }
            
            handler(tables, nil)
        }
    }
    
    
    func fetchDaysDatesDict(tableId: String,
                            _ handler: @escaping ([Int: [Date]]?, String?) -> ()) {
        
        guard let orderedDates = tableOrderedDatesDict[tableId] else {
            handler(nil, "Неизвестная ошибка")
            return
        }
        
        let allDates = getAllDates()
        let freeDates = allDates.filter { (date) -> Bool in
            return !orderedDates.contains(date)
        }
        let calendar = Calendar.current
        let availableDates = freeDates.filter { (date) -> Bool in
            let weekDay = calendar.component(.weekday, from: date)
            if let startDate = weekDaysDates[weekDay]?.startDate,
                let endDate = weekDaysDates[weekDay]?.endDate {
                
                let dateString = date.string(in: "dd.MM.yyyy")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                let currentDayStartDate = dateFormatter.date(from: dateString)
                if let resultStartDate = currentDayStartDate?.addingTimeInterval(startDate.timeIntervalSince1970),
                    let resultEndDate = currentDayStartDate?.addingTimeInterval(endDate.timeIntervalSince1970) {
                    return date >= resultStartDate && date <= resultEndDate
                }
            }
            return false
        }
        
        var daysDatesDict: [Int: [Date]] = [:]
        availableDates.forEach { (date) in
            let currentDate = Date()
            let currentDateString = currentDate.addingTimeInterval(TimeInterval(24*60*60)).string(in: "dd.MM.yyyy")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            guard let nextDayDate = dateFormatter.date(from: currentDateString) else {
                handler(nil, "Дата следующего дня не получена")
                return
            }
            if date.timeIntervalSince1970 - nextDayDate.timeIntervalSince1970 < 0 {
                if daysDatesDict[0] == nil {
                    daysDatesDict[0] = [date]
                } else {
                    daysDatesDict[0]?.append(date)
                }
            } else {
                let secondsOver = Int(date.timeIntervalSince1970 - nextDayDate.timeIntervalSince1970)
                let daysOver = secondsOver / (24*60*60) + 1
                if daysDatesDict[daysOver] == nil {
                    daysDatesDict[daysOver] = [date]
                } else {
                    daysDatesDict[daysOver]?.append(date)
                }
            }
        }
        handler(daysDatesDict, nil)
        let daysDatesDictStrings = daysDatesDict.map { (key, value) -> String in
            let datesStrings = value.map { (date) -> String in
                return date.string(in: "d MMMM HH:mm")
            }
            return "\(key)\n\(datesStrings.joined(separator: "\n"))"
        }
        print(daysDatesDictStrings.joined(separator: "\n"))
    }
    
    
    //MARK: Private Funcs
    
    
    
    private func getAllDates() -> [Date] {
        var allDates: [Date] = []
        let currentDate = Date()
        let currentDate1970Int = Int(currentDate.timeIntervalSince1970)
        let currentRoundedDate1970 = currentDate1970Int + (30*60 - currentDate1970Int % (30*60))
        let maxDate1970 = currentRoundedDate1970 + 30*24*60*60
        var currentRoundedDate = Date(timeIntervalSince1970: TimeInterval(currentRoundedDate1970))
        let maxDate = Date(timeIntervalSince1970: TimeInterval(maxDate1970))
        
        while currentRoundedDate < maxDate {
            allDates.append(currentRoundedDate)
            currentRoundedDate = currentRoundedDate.addingTimeInterval(30*60)
        }
        return allDates
    }
    
    
    private func configureWeekDaysDates(workDaysDict: [String: Any]?) {
        let weekDaysStrings = ["monday", "tuesday", "wednesDay", "thursDay", "friday", "saturday", "sunday"]
        for weekDayString in weekDaysStrings {
            if self.weekDaysDates[self.getWeekDayNumber(by: weekDayString)] == nil {
                let mondayDict = workDaysDict?[weekDayString] as? [String: Int]
                let startDateInt = mondayDict?["startDate"] ?? 0
                let endDateInt = mondayDict?["endDate"] ?? 0
                let startDate = Date(timeIntervalSince1970: TimeInterval(startDateInt))
                let endDate = Date(timeIntervalSince1970: TimeInterval(endDateInt))
                self.weekDaysDates[self.getWeekDayNumber(by: weekDayString)] = (startDate: startDate, endDate: endDate)
            }
        }
        print(weekDaysDates)
    }
    
    private func getWeekDayNumber(by string: String) -> Int {
        switch string {
        case "monday":
            return 1
        case "tuesday":
            return 2
        case "wednesDay":
            return 3
        case "thursDay":
            return 4
        case "friday":
            return 5
        case "saturday":
            return 6
        case "sunday":
            return 7
        default:
            return 0
        }
    }
    
    
}
