//
//  AuthEnterPhoneModel.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 13.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class AuthEnterPhoneModel {
    
    
    func sendCode(to phone: String,
                  _ handler: @escaping (Bool, String?) -> ()) {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
            handler(true, nil)
        }
    }
}
