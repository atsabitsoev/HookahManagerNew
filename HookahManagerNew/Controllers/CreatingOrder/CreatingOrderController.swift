//
//  CreatingOrderController.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class CreatingOrderController {
    
    
    init(view: CreatingOrderView) {
        self.view = view
        self.model = CreatingOrderModel()
    }
    
    
    private var view: CreatingOrderView!
    private var model: CreatingOrderModel!
    
    
    func viewDidLoad() {
        view.setDelegates()
    }
    
    
}
