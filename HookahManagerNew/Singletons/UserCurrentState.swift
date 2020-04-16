//
//  UserCurrentState.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 13.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class UserCurrentState {
    
    private init() {}
    static let standard = UserCurrentState()
    
    
    private var userId: String? {
        get {
            UserDefaults.standard.string(forKey: "userId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
    }
    
    private var restaurantId: String? {
        get {
            UserDefaults.standard.string(forKey: "restaurantId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "restaurantId")
        }
    }
    
    
    //Log in
    func loginSave(userId: String, restaurantId: String) {
        self.userId = userId
        self.restaurantId = restaurantId
    }
    
    //Log out
    func logoutSave() {
        self.userId = nil
        self.restaurantId = nil
    }
    
    //get restaurantId
    func getRestaurantId() -> String? {
        return restaurantId
    }
    
}
