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

        self.controller = OrderListController(view: self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func butAddTapped(_ sender: Any) {
        controller.butAddTapped()
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
            self.controller.trailingSwipe(index: indexPath.row)
        }
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = items[indexPath.row]
        let action = item.leadingSwipeType.getSwipeAction { (_, _, _) in
            self.controller.leadingSwipe(index: indexPath.row)
        }
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
}
