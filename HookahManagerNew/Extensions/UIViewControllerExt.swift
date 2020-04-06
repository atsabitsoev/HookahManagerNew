//
//  UIViewControllerExt.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 06.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func alertSuccess(_ message: String,
                      completion: @escaping () -> ()) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: { _ in
            completion()
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
