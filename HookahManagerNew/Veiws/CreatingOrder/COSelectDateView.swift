//
//  COSelectDateView.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 05.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


enum COSelectDateViewState {
    case days
    case times
}


class COSelectDateView: UIViewController {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    private var state: COSelectDateViewState = .days
    private var selectedDayItem: DayItem?
    
    
    private var dayItems: [DayItem] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        setMokDayItems()
    }
    
    private func setMokDayItems() {
        let item1 = DayItem(id: 1,
                            dayString: "5 марта",
                            times: [Date(timeIntervalSince1970: 1583431200),
                                    Date(timeIntervalSince1970: 1583431200 + 60*60)])
        let item2 = DayItem(id: 2,
                            dayString: "6 марта",
                            times: [Date(timeIntervalSince1970: 1583506800),
                                    Date(timeIntervalSince1970: 1583506800 + 30*60)])
        self.dayItems = [item1, item2]
    }
    
    
    private func reloadPickerView() {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.pickerView.alpha = 0
        }) { (_) in
            self.pickerView.reloadAllComponents()
            UIView.animate(withDuration: 0.3) {
                self.pickerView.alpha = 1
            }
        }
    }
    
    
    @IBAction func butSelectTapped(_ sender: Any) {
        switch state {
        case .days:
            let selectedDayItemIndex = pickerView.selectedRow(inComponent: 0)
            let selectedDayItem = dayItems[selectedDayItemIndex]
            self.selectedDayItem = selectedDayItem
            state = .times
            reloadPickerView()
        case .times:
            let selectedDateIndex = pickerView.selectedRow(inComponent: 0)
            let selectedDate = selectedDayItem?.times[selectedDateIndex]
            print(selectedDate?.string(in: "d MMMM, HH:mm") ?? "Невозможно определить выбранную дату")
        }
    }
    
}


extension COSelectDateView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch state {
        case .days:
            return dayItems.count
        case .times:
            return selectedDayItem?.times.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        switch state {
        case .days:
            let item = dayItems[row]
            return item.dayString
        case .times:
            guard let timeDate = selectedDayItem?.times[row] else { return "Нет доступных дат" }
            let timeString = timeDate.string(in: "HH:mm")
            return timeString
        }
    }
    
}
