//
//  OrderListController.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 02.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class OrderListController {
    

    init(view: OrderListView) {
        self.view = view
        self.model = OrderListModel()
    }

    
    private var model: OrderListModel!
    private var view: OrderListView!
    
    
    func trailingSwipe(index: Int) {
        print("Свайп справа index: \(index)")
    }
    
    func leadingSwipe(index: Int) {
        print("Свайп слева index: \(index)")
    }
    
    
    func butAddTapped() {
        
    }

}
