//
//  AuthEnterPhoneModel.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 13.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import FirebaseAuth


class AuthEnterPhoneModel {
    
    
    func sendCode(to phone: String,
                  _ handler: @escaping (_ verificationId: String?, _ errorString: String?) -> ()) {
        
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationId, error) in
            guard let verificationId = verificationId else {
                handler(nil, error?.localizedDescription)
                print(error)
                return
            }
            handler(verificationId, nil)
        }
    }
}
