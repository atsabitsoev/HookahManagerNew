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
    
    
    private let codeLength = 4
    
    
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
            checkCode(newCode)
        }
    }
    
    private func checkCode(_ code: String) {
        print("Проверяем код: \(code)")
    }
    
}
