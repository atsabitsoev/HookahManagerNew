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
    
    
    private var tables: [Table] = []
    
    
    func viewDidLoad() {
        view.configureView()
        view.setDelegates()
        
        fetchTables()
    }
    
    func sizeSelected(id: String, selected: Bool) {
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
        view.setOptionsItemSelected(tableId: id, selected: !selected)
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
                                 description: "Максимум \(table.size.count) человек(а)",
                                 selected: false)
        }
        let uniqueItems = Array(Set(sizeItems))
        let sortedItems = uniqueItems.sorted { (item1, item2) -> Bool in
            return item1.sizeId.count < item2.sizeId.count
        }
        return sortedItems
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
    
}
