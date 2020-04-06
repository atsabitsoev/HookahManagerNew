//
//  DateExt.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


extension Date {
    
    func string(in format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "RU")
        let result = dateFormatter.string(from: self)
        return result
    }
}
