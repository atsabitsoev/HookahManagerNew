//
//  OrderListModel.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 02.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import FirebaseFirestore


class OrderListModel {
    
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
                    let date = (docData["dateTime"] as? Timestamp)?.dateValue()
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
                                 date: date ?? Date(timeIntervalSince1970: 0),
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
    
    func changeOrderStatus(_ handler: @escaping (Bool, Error?) -> ()) {
        Timer.scheduledTimer(withTimeInterval: 0.3,
                             repeats: false) { (_) in
                                handler(true, nil)
        }
    }
}
