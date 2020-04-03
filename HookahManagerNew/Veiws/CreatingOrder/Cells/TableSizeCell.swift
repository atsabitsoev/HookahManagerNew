//
//  TableSizeCell.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class TableSizeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageTable: UIImageView!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var labDescription: UILabel!
    
    
    func configure(with sizeItem: TableSizeItem) {
        labName.text = sizeItem.name
        labDescription.text = sizeItem.description
    }
}
