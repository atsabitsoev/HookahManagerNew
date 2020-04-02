//
//  OrderListItem.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 02.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


struct OrderListItem {
    
    var dateTime: String
    var tableDescription: String
    var customerName: String
    var options: String
    var number: String
    var status: String
    
    var trailingSwipeType: SwipeTypes
    var leadingSwipeType: SwipeTypes
}
