//
//  AuthEnterPhoneVC.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 13.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import PhoneNumberKit


class AuthEnterPhoneVC: UIViewController {
    
    
    private var controller: AuthEnterPhoneController!

    
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var butEnterCode: UIButton!
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureModule()
        controller.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controller.viewDidAppear()
    }
    
    
    private func configureModule() {
        self.controller = AuthEnterPhoneController(view: self, model: AuthEnterPhoneModel())
    }
    
    
    func showKeyboard() {
        tfPhone.becomeFirstResponder()
    }
    
    
    func enableButEnterCode(_ enable: Bool) {
        butEnterCode.isUserInteractionEnabled = enable
        butEnterCode.alpha = enable ? 1 : 0.5
    }
    
    
    //MARK: Navigation
    func showAuthEnterCodeVC() {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AuthEnterCodeVC")
        self.navigationController?.show(vc, sender: nil)
    }
    
    
    //MARK: IBOutlets
    @IBAction func tfChanged(_ sender: PhoneNumberTextField) {
        if let text = sender.text {
            controller.phoneTextChanged(newText: text, isValidPhone: sender.isValidNumber)
        }
    }
    
    @IBAction func butEnterCodeTapped(_ sender: Any) {
        controller.butEnterCodeTapped()
    }
    
}
