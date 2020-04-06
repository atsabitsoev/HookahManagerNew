//
//  SizeItem.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


struct TableSizeItem: Hashable {
    
    var sizeId: String
    var name: String
    var customerCount: Int
    var description: String {
        get {
            return "Максимум \(customerCount) человек(а)"
        }
    }
    var selected: Bool
}
