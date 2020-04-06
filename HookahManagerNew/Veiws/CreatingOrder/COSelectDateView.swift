//
//  COSelectDateView.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 05.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


protocol COSelectDateViewDelegate {
    
    func dateSelected(_ date: Date) -> ()
}


enum COSelectDateViewState {
    case days
    case times
}


class COSelectDateView: UIViewController {
    
    
    var delegate: COSelectDateViewDelegate?
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    private var state: COSelectDateViewState = .days
    private var selectedDayItem: DayItem?
    
    
    private var dayItems: [DayItem] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickerView.reloadAllComponents()
    }
    
    
    func configureView(dayItems: [DayItem],
                       delegate: COSelectDateViewDelegate) {
        self.delegate = delegate
        self.dayItems = dayItems
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
            if let selectedDate = selectedDayItem?.times[selectedDateIndex] {
                delegate?.dateSelected(selectedDate)
                self.dismiss(animated: true, completion: nil)
            }
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
