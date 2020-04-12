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
    
    
    //MARK: IBOutlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var colViewSize: UICollectionView!
    @IBOutlet weak var colViewOptions: UICollectionView!
    @IBOutlet weak var viewTableSize: UIView!
    @IBOutlet weak var viewOptions: UIView!
    @IBOutlet weak var tfCustomerName: UITextField!
    @IBOutlet weak var butChooseDate: UIButton!
    
    
    //MARK: Vars And Lets
    //Condition
    private var currentViewInset: CGFloat = 0
    
    //CollectionView
    private var sizeItems: [TableSizeItem] = []
    private var optionsItems: [OptionsItem] = []
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModule()
        controller.viewDidLoad()
    }
    
    
    //MARK: Configuration
    private func configureModule() {
        controller = CreatingOrderController(view: self)
    }
    
    func configureView() {
        viewOptions.isHidden = true
    }
    
    
    func setDelegates() {
        colViewSize.delegate = self
        colViewSize.dataSource = self
        colViewOptions.delegate = self
        colViewOptions.dataSource = self
        tfCustomerName.delegate = self
    }
    
    
    //MARK: ButChooseDate Enabling
    func enableButChooseDate(_ enable: Bool) {
        if enable {
            butChooseDate.isEnabled = true
            butChooseDate.alpha = 1
        } else {
            butChooseDate.isEnabled = false
            butChooseDate.alpha = 0.5
        }
    }
    
    
    //MARK: Keyboard
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func viewUp() {
        let keyboardHeight: CGFloat = 300
        let inset = self.view.frame.maxY - stackView.frame.maxY - keyboardHeight
        print(inset)
        guard inset < 0 else { return }
        UIView.animate(withDuration: 0.3) {
            self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: inset, left: 0, bottom: -inset, right: 0))
        }
        currentViewInset = inset
    }
    
    func viewDown() {
        let inset = currentViewInset
        print(inset)
        guard inset < 0 else { return }
        UIView.animate(withDuration: 0.2) {
            self.view.frame = self.view.frame.inset(by: UIEdgeInsets(top: -inset, left: 0, bottom: inset, right: 0))
        }
        currentViewInset = 0
    }
    
    
    //MARK: Updating Collections
    func updateSizeItems(_ items: [TableSizeItem]) {
        sizeItems = items.sorted(by: { (item1, item2) -> Bool in
            return item1.customerCount < item2.customerCount
        })
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
    
    
    //MARK: Item Selected
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
    
    
    //MARK: Alerts
    func alertOrderCreated(_ handler: @escaping () -> ()) {
        self.alertSuccess("Забронировано!", completion: handler)
    }
    
    
    //MARK: Navigation
    func showCOSelectDateView(dayItems: [DayItem]) {
        let storyboard = UIStoryboard(name: "CreatingOrder", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "COSelectDateView") as! COSelectDateView
        vc.configureView(dayItems: dayItems,
                         delegate: self)
        self.present(vc, animated: true, completion: nil)
    }
    
    func goBackToMain() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    //MARK: Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        controller.viewTapped()
    }
    
    
    //MARK: IBActions
    @IBAction func butChooseDateTapped(_ sender: Any) {
        controller.butChooseDateTapped()
    }
    

}


//MARK: COSelectDateView Delegate
extension CreatingOrderView: COSelectDateViewDelegate {
    
    func dateSelected(_ date: Date) {
        controller.dateSelected(date)
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


//MARK: TextField Delegate
extension CreatingOrderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        controller.tfReturned(name: textField.text)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        controller.tfDidBeginEditing()
    }
}