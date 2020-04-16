//
//  CreatingOrderController.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class CreatingOrderController {
    
    
    init(view: CreatingOrderView, model: CreatingOrderModel) {
        self.view = view
        self.model = model
    }
    
    
    private var view: CreatingOrderView!
    private var model: CreatingOrderModel!
    
    
    private var tables: [Table] = []
    private var selectedTableId: String?
    private var customerName: String?
    
    
    func viewDidLoad() {
        view.configureView()
        view.enableButChooseDate(false)
        view.setDelegates()
        
        fetchTables()
    }
    
    @objc func viewTapped() {
        view.viewDown()
        view.hideKeyboard()
    }
    
    func tfReturned(name: String?) {
        self.customerName = name
        checkReadinessToChooseDate()
        view.viewDown()
        view.hideKeyboard()
    }
    
    func tfDidBeginEditing() {
        view.viewUp()
    }
    
    
    func sizeSelected(id: String, selected: Bool) {
        selectedTableId = nil
        checkReadinessToChooseDate()
        
        let toBeSelected = !selected
        if toBeSelected {
            let optionsItems = getOptionsItems(sizeId: id)
            view.updateOptionsItems(optionsItems)
            view.showViewOptions()
        } else {
            view.hideViewOptions()
        }
        view.setSizeItemSelected(sizeId: id, selected: toBeSelected)
    }
    
    func optionsSelected(id: String, selected: Bool) {
        let toBeSelected = !selected
        selectedTableId = toBeSelected ? id : nil
        checkReadinessToChooseDate()
        view.setOptionsItemSelected(tableId: id, selected: toBeSelected)
    }
    
    
    func dateSelected(_ date: Date) {
        
        let selectedTable = tables.filter { (table) -> Bool in
            return self.selectedTableId == table.id
        }.first
        guard let customerName = self.customerName,
            let table = selectedTable else { return }
        let order = Order(id: "",
                          customerName: customerName ,
                          number: "",
                          date: date,
                          status: .approved,
                          table: table)
        model.createOrder(order: order) { (succeed, errorString) in
            if succeed {
                self.view.alertOrderCreated {
                    self.view.goBackToMain()
                }
            } else {
                self.view.alertError(errorString)
            }
        }
    }
    
    
    func butChooseDateTapped() {
        guard let tableId = selectedTableId else {
            print("Не удалось получить id выбранного столика")
            return
        }
        model.fetchDaysDatesDict(tableId: tableId) { (dict, errorString) in
            guard let dict = dict else {
                print(errorString ?? "Неизвестная ошибка")
                return
            }
            let sortedDict = dict.sorted { (item1, item2) -> Bool in
                return item1.key < item2.key
            }
            let dayItems = sortedDict.map { (key, value) -> DayItem in
                let dayDate = Date().addingTimeInterval(TimeInterval(key * 24 * 60 * 60))
                let dayString = dayDate.string(in: "d MMMM")
                return DayItem(id: key,
                               dayString: dayString,
                               times: value)
            }
            self.view.showCOSelectDateView(dayItems: dayItems)
        }
    }
    
    
    private func fetchTables() {
        model.fetchTables { (tables, errorString) in
            guard let tables = tables else {
                print(errorString ?? "Неизвестная ошибка")
                return
            }
            self.tables = tables
            
            let sizeItems = self.getSizeItems(from: tables)
            self.view.updateSizeItems(sizeItems)
        }
    }
    
    private func getSizeItems(from tables: [Table]) -> [TableSizeItem] {
        let sizeItems = tables.map { (table) -> TableSizeItem in
            return TableSizeItem(sizeId: table.size.id,
                                 name: table.size.name,
                                 customerCount: table.size.count,
                                 selected: false)
        }
        let uniqueItems = Array(Set(sizeItems))
        return uniqueItems
    }
    
    private func getOptionsItems(sizeId: String) -> [OptionsItem] {
        let optionsItems = tables.compactMap { (table) -> OptionsItem? in
            guard table.size.id == sizeId else { return nil }
            return OptionsItem(tableId: table.id,
                               options: table.options,
                               selected: false)
        }
        return optionsItems
    }
    
    
    private func checkReadinessToChooseDate() {
        var isReady = false
        if let _ = selectedTableId,
            let name = customerName, !name.isEmpty {
            isReady = true
        }
        view.enableButChooseDate(isReady)
    }
    
}
