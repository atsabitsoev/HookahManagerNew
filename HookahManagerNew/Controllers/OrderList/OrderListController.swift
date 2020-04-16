//
//  OrderListController.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 02.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class OrderListController {
    

    init(view: OrderListView, model: OrderListModel) {
        self.view = view
        self.model = model
    }

    
    private var model: OrderListModel!
    private var view: OrderListView!
    
    
    private var orders: [Order] = []
    
    
    //MARK: View Triggers
    func viewDidLoad() {
        view.setDelegates()
        startOrderListener()
    }
    
    func swipe(orderId: String, swipeType: SwipeTypes) {
        switch swipeType {
        case .denie, .annul:
            changeOrderStatus(orderId: orderId, status: .deniedByManager)
        case .approve:
            changeOrderStatus(orderId: orderId, status: .approved)
        case .finish:
            changeOrderStatus(orderId: orderId, status: .finished)
        }
    }
    
    func butAddTapped() {
        view.showCreatingOrderView()
    }
    
    
    //MARK: Private Functions
    private func startOrderListener() {
        model.startOrdersListener { (orders, error) in
            guard let orders = orders else { return }
            self.showOrderItems(orders: orders)
        }
    }
    
    private func changeOrderStatus(orderId: String, status: OrderStatus) {
        let orderIndex = orders.firstIndex { (order) -> Bool in
            return order.id == orderId
        }
        guard let index = orderIndex else { return }
        
        var newOrder = orders[index]
        newOrder.status = status
        
        switch status {
        case .approved, .waiting:
            view.updateItem(orderId: orderId, newItem: getOrderListItem(from: newOrder))
        default:
            view.deleteItem(orderId: orderId)
        }
        
        model.changeOrderStatus(orderId: orderId,
                                status: status.rawValue) { (succeed, errorString) in
                                    
            if succeed {
                self.orders[index] = newOrder
            } else {
                self.view.alertError(errorString ?? "Неизвестная ошибка")
            }
            self.showOrderItems(orders: self.orders)
        }
    }
    
    
    private func showOrderItems(orders: [Order]) {
        self.orders = orders
        
        let filteredOrders = orders.filter { (order) -> Bool in
            return order.status == .approved || order.status == .waiting
        }
        let orderListItems = filteredOrders.map { (order) -> OrderListItem in
            return self.getOrderListItem(from: order)
        }
        self.view.updateItems(orderListItems)
    }
    
    
    private func getOrderListItem(from order: Order) -> OrderListItem {
        let id = order.id
        let dateTime = order.date.string(in: "HH:mm, d MMMM")
        let tableDescription = "\(order.table.size.count) персон(ы)"
        let customerName = order.customerName
        let options = order.table.options.joined(separator: "\n")
        let number = order.number
        let status = order.status.rawValue
        let trailingSwipeType = order.status == .waiting ? SwipeTypes.denie : SwipeTypes.annul
        let leadingSwipeType = order.status == .waiting ? SwipeTypes.approve : SwipeTypes.finish
        return OrderListItem(orderId: id,
                             dateTime: dateTime,
                             tableDescription: tableDescription,
                             customerName: customerName,
                             options: options,
                             number: number,
                             status: status,
                             trailingSwipeType: trailingSwipeType,
                             leadingSwipeType: leadingSwipeType)
    }

}
