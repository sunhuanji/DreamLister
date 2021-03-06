//
//  ItemDetailViewController.swift
//  DreamLister
//
//  Created by Sun Huanji on 2016/10/21.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var thumImage: UIImageView!
    
    var stores = [Store]()
    var itemToEdit:Item?
    var imagePicker:UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        storePicker.delegate = self
        storePicker.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        getStores()
        if itemToEdit != nil{
         loadItemData()
        }
                let store = Store(context: context)
                store.name = "Best Buy"
                let store2 = Store(context: context)
                store2.name = "Tesla Dealership"
                let store3 = Store(context: context)
                store3.name = "Frys Electronics"
                let store4 = Store(context: context)
                store4.name = "Target"
                let store5 = Store(context: context)
                store5.name = "Amazon"
                let store6 = Store(context: context)
                store6.name = "K Mart"
                
                ad.saveContext()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
    }
    
    func getStores(){
        let fetchRequest:NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch{
            
        }
    }
    @IBAction func deletePressed(_ sender: AnyObject) {
        if itemToEdit != nil{
            context.delete(itemToEdit!)
            ad.saveContext()
            
        }
        
       _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func savePressed(_ sender: AnyObject) {
        var item:Item!
        
        let picture = Image(context:context)
        picture.image = thumImage.image
      
        
        if itemToEdit == nil{
            item = Item(context:context)
            
        }else {
          item = itemToEdit
        }
        
        
        item.toImage = picture
        if let title = titleField.text{
         item.title = title
        }
        if let price = priceField.text{
         item.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text{
         item.details = details
        }
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    @IBAction func addImage(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
         thumImage.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func loadItemData() {
        if let item = itemToEdit{
         titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            thumImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore{
            var index = 0
                repeat{
                let s = stores[index]
                    if s.name == store.name{
                      storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                }while(index < stores.count)
            }
        }
    }

}
