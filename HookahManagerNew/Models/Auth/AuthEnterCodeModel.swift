//
//  AuthEnterCodeModel.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 13.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class AuthEnterCodeModel {
    
    
    let db = Firestore.firestore()
    
    
    func signIn(verificationId: String,
                code: String,
                _ handler: @escaping (_ restaurantId: String?, _ userId: String?, _ errorString: String?) -> ()) {
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            guard let result = result else {
                print(error)
                return
            }
            let user = result.user
            self.getRestaurant(phone: user.phoneNumber) { (restaurantId, errorString) in
                handler(restaurantId, user.uid, errorString)
            }
        }
    }
    
    private func getRestaurant(phone: String?,
                               _ handler: @escaping (_ restaurantId: String?, _ errorString: String?) -> ()) {
        
        guard let phone = phone else {
            handler(nil, "Телефон пользователя не определен")
            return
        }
        
        db.collection("managers").whereField("phone", isEqualTo: phone).getDocuments { (query, error) in
            guard let documents = query?.documents, documents.count > 0 else {
                handler(nil, "Не удалось получить данные")
                return
            }
            guard documents.count == 1 else {
                handler(nil, "Обнаружено несколько менеджеров с данным номером телефона!")
                return
            }
            let manager = documents.first!
            let managerData = manager.data()
            guard let restaurantId = managerData["restaurantId"] as? String else {
                handler(nil, "У данного менеджера не указан id ресторана")
                return
            }
            handler(restaurantId, nil)
        }
    }
}
