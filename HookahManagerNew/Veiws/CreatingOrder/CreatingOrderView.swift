//
//  CreatingOrderView.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 03.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class CreatingOrderView: UIViewController {
    
    
    private var controller: CreatingOrderController!
    
    
    @IBOutlet weak var colViewSize: UICollectionView!
    @IBOutlet weak var colViewOptions: UICollectionView!
    @IBOutlet weak var viewTableSize: UIView!
    @IBOutlet weak var viewOptions: UIView!
    
    
    private var sizeItems: [TableSizeItem] = []
    private var optionsItems: [OptionsItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModule()
        controller.viewDidLoad()
    }
    
    
    private func configureModule() {
        self.controller = CreatingOrderController(view: self)
    }
    
    func configureView() {
        viewOptions.isHidden = true
    }
    
    
    func setDelegates() {
        colViewSize.delegate = self
        colViewSize.dataSource = self
        colViewOptions.delegate = self
        colViewOptions.dataSource = self
    }
    
    
    func updateSizeItems(_ items: [TableSizeItem]) {
        sizeItems = items
        colViewSize.reloadData()
    }
    
    func updateOptionsItems(_ items: [OptionsItem]) {
        optionsItems = items
        colViewOptions.reloadData()
    }
    
    
    func showViewOptions() {
        guard viewOptions.isHidden else { return }
        colViewOptions.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.viewOptions.isHidden = false
        }) { (_) in
            UIView.animate(withDuration: 0.3) {
                self.colViewOptions.alpha = 1
            }
        }
    }
    
    func hideViewOptions() {
        guard !viewOptions.isHidden else { return }
        colViewOptions.alpha = 1
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.colViewOptions.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: 0.3) {
                self.viewOptions.isHidden = true
            }
        }
    }
    
    
    func setSizeItemSelected(sizeId: String, selected: Bool) {
        sizeItems = sizeItems.map { (item) -> TableSizeItem in
            var item = item
            if item.selected {
                item.selected = false
            }
            return item
        }
        
        let index = sizeItems.firstIndex { (item) -> Bool in
            return item.sizeId == sizeId
        }
        guard let itemIndex = index else { return }
        var item = sizeItems[itemIndex]
        item.selected = selected
        sizeItems[itemIndex] = item
        colViewSize.reloadData()
    }
    
    func setOptionsItemSelected(tableId: String, selected: Bool) {
        optionsItems = optionsItems.map({ (item) -> OptionsItem in
            var item = item
            if item.selected {
                item.selected = false
            }
            return item
        })
        
        let index = optionsItems.firstIndex { (item) -> Bool in
            return item.tableId == tableId
        }
        guard let itemIndex = index else { return }
        var item = optionsItems[itemIndex]
        item.selected = selected
        optionsItems[itemIndex] = item
        colViewOptions.reloadData()
    }

}


//MARK: Collection Views
extension CreatingOrderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colViewSize {
            return sizeItems.count
        }
        
        if collectionView == colViewOptions {
            return optionsItems.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colViewSize {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableSizeCell", for: indexPath) as! TableSizeCell
            let item = sizeItems[indexPath.row]
            cell.configure(with: item)
            return cell
        }
        
        if collectionView == colViewOptions {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionsCell", for: indexPath) as! OptionsCell
            let item = optionsItems[indexPath.row]
            cell.configure(with: item)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colViewSize {
            let item = sizeItems[indexPath.row]
            controller.sizeSelected(id: item.sizeId, selected: item.selected)
        }
        
        if collectionView == colViewOptions {
            let item = optionsItems[indexPath.row]
            controller.optionsSelected(id: item.tableId, selected: item.selected)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 109, height: 109)
    }
    
}
