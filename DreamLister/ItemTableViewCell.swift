//
//  ItemTableViewCell.swift
//  DreamLister
//
//  Created by Sun Huanji on 2016/10/21.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {


    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func configureCell(item:Item){
    title.text = item.title
    price.text = "$\(item.price)"
    details.text = item.details
    itemImage.image = item.toImage?.image as? UIImage
    }

}
