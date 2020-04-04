//
//  CreatingOrderModel.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class CreatingOrderModel {
    
    func fetchTables(_ handler: @escaping ([Table]?, String?) -> ()) {
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (_) in
            
            let tables = self.getMokTables()
            handler(tables, nil)
        }
    }
    
    
    private func getMokTables() -> [Table] {
        let table1 = Table(id: "1",
                           size: TableSize(id: "1", name: "Маленький", count: 2),
                           options: ["У окна", "С приставкой", "Мягкие сидения"])
        let table2 = Table(id: "2",
                           size: TableSize(id: "2", name: "Средний", count: 4),
                           options: ["У окна"])
        let table3 = Table(id: "3",
                           size: TableSize(id: "2", name: "Средний", count: 4),
                           options: ["С приставкой"])
        return [table1, table2, table3]
    }
}
