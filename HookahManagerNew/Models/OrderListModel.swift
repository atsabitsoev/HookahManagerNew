//
//  OrderListModel.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 02.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class OrderListModel {
    
    func fetchOrders(_ handler: @escaping ([Order]?, Error?) -> ()) {
        Timer.scheduledTimer(withTimeInterval: 0.3,
                             repeats: false) { (_) in
                                handler([Order(id: "idшник",
                                       customerName: "Геннадий",
                                       number: "4256252443",
                                       date: Date(),
                                       status: .waiting,
                                       table: Table(id: "tableIdfdsf",
                                                    size: TableSize(id: "sizeId",
                                                                    name: "Маленький",
                                                                    count: 2),
                                                    options: ["У окна", "С игровой приставкой"]))],
                                nil)
        }
    }
    
    func changeOrderStatus(_ handler: @escaping (Bool, Error?) -> ()) {
        Timer.scheduledTimer(withTimeInterval: 0.3,
                             repeats: false) { (_) in
                                handler(true, nil)
        }
    }
}
