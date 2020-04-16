//
//  AuthEnterCodeController.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 13.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class AuthEnterCodeController {
    
    
    private var view: AuthEnterCodeVC!
    private var model: AuthEnterCodeModel!
    
    private let userCurrentState = UserCurrentState.standard
    
    
    var verificationId: String!
    private let codeLength = 6
    
    
    init(view: AuthEnterCodeVC, model: AuthEnterCodeModel) {
        self.view = view
        self.model = model
    }
    
    
    func viewDidLoad() {
        view.configureView(codeLength: codeLength)
    }
    
    func viewDidAppear() {
        view.showKeyboard()
    }
    
    
    func codeChanged(to newCode: String) {
        if newCode.count == codeLength {
            checkCode(verificationId: verificationId, code: newCode)
        }
    }
    
    private func checkCode(verificationId: String, code: String) {
        model.signIn(verificationId: verificationId, code: code) { (restaurantId, userId, errorString) in
            
            guard let restaurantId = restaurantId,
                let userId = userId else {
                    
                self.view.alertError(errorString)
                return
            }
            
            self.userCurrentState.loginSave(userId: userId, restaurantId: restaurantId)
            self.view.showMainTabBar()
        }
    }
    
}
