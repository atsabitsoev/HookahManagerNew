//
//  OptionsCell.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 04.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class OptionsCell: UICollectionViewCell {
    
    
    @IBOutlet weak var labOptions: UILabel!
    
    
    func configure(with optionsItem: OptionsItem) {
        labOptions.text = optionsItem.options.joined(separator: ",\n")
    }
}
