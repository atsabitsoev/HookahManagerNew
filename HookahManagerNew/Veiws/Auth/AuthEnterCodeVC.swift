//
//  AuthEnterCodeVC.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 13.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class AuthEnterCodeVC: UIViewController {
    
    
    private var controller: AuthEnterCodeController!
    var verificationId: String!
    
    
    @IBOutlet weak var tfCode: UITextField!
    
    
    private var codeLength: Int!
    
    
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
        controller = AuthEnterCodeController(view: self, model: AuthEnterCodeModel())
        controller.verificationId = verificationId
    }
    
    
    func showKeyboard() {
        tfCode.becomeFirstResponder()
    }
    
    
    func configureView(codeLength: Int) {
        self.codeLength = codeLength
        tfCode.placeholder = Array(1...codeLength).map({ (i) -> String in
            return "X"
            }).joined()
        tfCode.delegate = self
    }
    
    
    //MARK: Navigation
    func showMainTabBar() {
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        let mainTabBar = storyboard.instantiateViewController(withIdentifier: "MainTabBar")
        mainTabBar.modalPresentationStyle = .fullScreen
        mainTabBar.modalTransitionStyle = .flipHorizontal
        self.navigationController?.present(mainTabBar, animated: true, completion: nil)
    }

    
    //MARK: IBActions
    @IBAction func tfCodeChanged(_ sender: UITextField) {
        if let code = sender.text {
            controller.codeChanged(to: code)
        }
    }
    
}


//MARK: TEXTFIELD DELEGATE
extension AuthEnterCodeVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if text.count < codeLength || (string.count == 0 && range.length > 0) {
            return true
        } else {
            return false
        }
    }
}
