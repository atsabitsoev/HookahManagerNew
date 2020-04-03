//
//  OrderStatus.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


enum OrderStatus: String {
    
    case waiting
    case approved
    case deniedByUser
    case deniedByManager
    case finished
}