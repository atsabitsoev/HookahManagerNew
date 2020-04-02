//
//  OrderListItemCell.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 02.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class OrderListItemCell: UITableViewCell {
    
    
    @IBOutlet weak var labDateTime: UILabel!
    @IBOutlet weak var labTableDescription: UILabel!
    @IBOutlet weak var labCustomerName: UILabel!
    @IBOutlet weak var labOptions: UILabel!
    @IBOutlet weak var labNumber: UILabel!
    @IBOutlet weak var labStatus: UILabel!
    
    
    func configure(with item: OrderListItem) {
        labDateTime.text = item.dateTime
        labTableDescription.text = item.tableDescription
        labCustomerName.text = item.customerName
        labOptions.text = item.options
        labNumber.text = item.number
        labStatus.text = item.status
    }

}
