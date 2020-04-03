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
    
    
    private var sizeItems: [TableSizeItem] = []
    private var optionsItems: [OptionsItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModule()
        controller.viewDidLoad()
        
        sizeItems = [TableSizeItem(sizeId: "null", name: "Маленький", description: "Столик на двоих"),
                     TableSizeItem(sizeId: "sdf", name: "Средний", description: "Столик на 4 человека"),
                     TableSizeItem(sizeId: "ehr", name: "Большой", description: "Стол на 10 человек")]
        optionsItems = [OptionsItem(options: ["У окна", "С приставкой", "Мягкие сидения"]),
                        OptionsItem(options: ["Возле туалета", "Возле бара"])]
    }
    
    
    private func configureModule() {
        self.controller = CreatingOrderController(view: self)
    }
    
    
    func setDelegates() {
        colViewSize.delegate = self
        colViewSize.dataSource = self
        colViewOptions.delegate = self
        colViewOptions.dataSource = self
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 117, height: 117)
    }
    
}
