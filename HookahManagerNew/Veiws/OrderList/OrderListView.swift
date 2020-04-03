//
//  OrderListView.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 02.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


class OrderListView: UIViewController {
    
    
    private var controller: OrderListController!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var items: [OrderListItem] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureModule()
        controller.viewDidLoad()
    }
    
    
    func configureModule() {
        self.controller = OrderListController(view: self)
    }
    
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func updateItems(_ items: [OrderListItem]) {
        self.items = items
        tableView.reloadData()
    }
    
    func updateItem(orderId: String, newItem: OrderListItem) {
        let itemIndex = items.firstIndex { (item) -> Bool in
            return item.orderId == orderId
        }
        guard let index = itemIndex else { return }
        
        self.items[index] = newItem
        let reloadingIndexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [reloadingIndexPath], with: .automatic)
    }
    
    func deleteItem(orderId: String) {
        let itemIndex = items.firstIndex { (item) -> Bool in
            return item.orderId == orderId
        }
        guard let index = itemIndex else { return }
        
        self.items.remove(at: index)
        let deleteIndexPath = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [deleteIndexPath], with: .automatic)
    }
    
    
    //MARK: IBActions
    @IBAction func butAddTapped(_ sender: Any) {
        controller.butAddTapped()
    }
    
    
    //MARK: Navigation
    func showCreatingOrderView() {
        let storyboard = UIStoryboard(name: "CreatingOrder", bundle: nil)
        let creatingOrderView = storyboard.instantiateViewController(withIdentifier: "CreatingOrderView") as! CreatingOrderView
        self.navigationController?.show(creatingOrderView, sender: nil)
    }
    
}


//MARK: TableView
extension OrderListView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListItemCell") as! OrderListItemCell
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = items[indexPath.row]
        let action = item.trailingSwipeType.getSwipeAction { (_, _, _) in
            let orderId = item.orderId
            self.controller.swipe(orderId: orderId, swipeType: item.trailingSwipeType)
        }
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = items[indexPath.row]
        let action = item.leadingSwipeType.getSwipeAction { (_, _, _) in
            let orderId = item.orderId
            self.controller.swipe(orderId: orderId, swipeType: item.leadingSwipeType)
        }
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
}
