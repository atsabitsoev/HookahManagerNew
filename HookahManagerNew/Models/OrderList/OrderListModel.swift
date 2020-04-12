//
//  OrderListModel.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 02.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFunctions


class OrderListModel {
    
    
    private lazy var functions = Functions.functions()
    
    
    func startOrdersListener(_ handler: @escaping ([Order]?, Error?) -> ()) {
        
        let db = Firestore.firestore()
        db.collection("restaurants")
            .document("iX2jYDuiTxBpofOUHcvL")
            .collection("orders")
            .addSnapshotListener { (querySnap, error) in
            
                guard let querySnap = querySnap else {
                    handler(nil, error ?? nil)
                    return
                }
            
                let documents = querySnap.documents
                let orders = documents.map { (document) -> Order in
                    let orderId = document.documentID
                    let docData = document.data()
                    let customerName = docData["customerName"] as? String
                    let number = docData["number"] as? String
                    let date = Date(timeIntervalSince1970: TimeInterval((docData["dateTime"] as? Int) ?? 0))
                    let status = OrderStatus(rawValue: (docData["status"] as? String) ?? "waiting")
                    let tableData = docData["table"] as? [String: Any]
                    let tableId = tableData?["tableId"] as? String
                    let options = tableData?["options"] as? [String]
                    let tableSizeData = tableData?["size"] as? [String: Any]
                    let tableSizeId = tableSizeData?["tableSizeId"] as? String
                    let maxCount = tableSizeData?["maxCount"] as? Int
                    let sizeName = tableSizeData?["name"] as? String
                    return Order(id: orderId,
                                 customerName: customerName ?? "Неизвестный посетитель",
                                 number: number ?? "null",
                                 date: date,
                                 status: status ?? .waiting,
                                 table: Table(id: tableId ?? "null",
                                              size: TableSize(id: tableSizeId ?? "null",
                                                              name: sizeName ?? "null",
                                                              count: maxCount ?? 0),
                                              options: options ?? []))
                }
                handler(orders, nil)
        }
    }
    
    func changeOrderStatus(orderId: String,
                           status: String,
                           _ handler: @escaping (Bool, String?) -> ()) {
        
        let restaurantId = "iX2jYDuiTxBpofOUHcvL"
        let dict: [String: Any] = ["orderId": orderId,
                                   "restaurantId": restaurantId,
                                   "status": status]
        functions.httpsCallable("changeOrderStatus").call(dict) { (result, error) in
            guard let result = result else {
                handler(false, error?.localizedDescription)
                return
            }
            let resultData = result.data as? [String: Any]
            let code = resultData?["code"] as? Int
            guard code == 200 else {
                if let message = resultData?["message"] as? String {
                    handler(false, message)
                } else {
                    handler(false, "Неизвестная ошибка")
                }
                return
            }
            handler(true, nil)
        }
    }
}
