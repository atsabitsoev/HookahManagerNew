//
//  Order.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


struct Order {
    
    var id: String
    var customerName: String
    var number: String
    var date: Date
    var status: OrderStatus
    var table: Table
}
