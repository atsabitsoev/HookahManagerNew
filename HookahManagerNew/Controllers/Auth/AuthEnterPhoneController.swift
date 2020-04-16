//
//  AuthEnterPhoneController.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 13.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class AuthEnterPhoneController {
    
    
    private var view: AuthEnterPhoneVC!
    private var model: AuthEnterPhoneModel!
    
    
    private var timer: Timer?
    private var phoneForModel: String?
    
    
    init(view: AuthEnterPhoneVC, model: AuthEnterPhoneModel) {
        self.view = view
        self.model = model
    }
    
    
    func viewDidLoad() {
        view.enableButEnterCode(false)
    }
    
    func viewDidAppear() {
        view.showKeyboard()
    }
    
    
    func phoneTextChanged(newText: String, isValidPhone: Bool) {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
            self.phoneForModel = isValidPhone ? self.getPhoneForModelString(from: newText) : nil
            self.view.enableButEnterCode(isValidPhone)
        })
    }
    
    private func getPhoneForModelString(from string: String) -> String {
        return string
    }
    
    
    private func sendCode(to phone: String) {
        model.sendCode(to: phone) { (verificationId, errorString) in
            guard let verificationId = verificationId else {
                self.view.alertError(errorString ?? "Не удалось отправить СМС, проверьте введенные данные")
                return
            }
            self.view.showAuthEnterCodeVC(verificationId: verificationId)
        }
    }
    
    
    func butEnterCodeTapped() {
        guard let phone = phoneForModel else { return }
        sendCode(to: phone)
    }
    
}
