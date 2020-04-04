//
//  CreatingOrderController.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class CreatingOrderController {
    
    
    init(view: CreatingOrderView) {
        self.view = view
        self.model = CreatingOrderModel()
    }
    
    
    private var view: CreatingOrderView!
    private var model: CreatingOrderModel!
    
    
    func viewDidLoad() {
        view.configureView()
        view.setDelegates()
        
        let sizeItems = [TableSizeItem(sizeId: "null", name: "Маленький", description: "Столик на двоих", selected: false),
                         TableSizeItem(sizeId: "sdf", name: "Средний", description: "Столик на 4 человека", selected: false),
                         TableSizeItem(sizeId: "ehr", name: "Большой", description: "Стол на 10 человек", selected: false),
                         TableSizeItem(sizeId: "dfgfg", name: "Гигантус", description: "300 спартанцев тут едят", selected: false)]
        view.updateSizeItems(sizeItems)
    }
    
    func sizeSelected(id: String, selected: Bool) {
        let toBeSelected = !selected
        if toBeSelected {
            view.updateOptionsItems([OptionsItem(tableId: "dgfdggf", options: ["Хужульдэ","Муопдв","Ещьмууц"], selected: false),
                                     OptionsItem(tableId: "ergwrge", options: ["sfjsbfswe", "тадеев Лох"], selected: false)])
            view.showViewOptions()
        } else {
            view.hideViewOptions()
        }
        view.setSizeItemSelected(sizeId: id, selected: toBeSelected)
    }
    
    func optionsSelected(id: String, selected: Bool) {
        view.setOptionsItemSelected(tableId: id, selected: !selected)
    }
    
    
}
