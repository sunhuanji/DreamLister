//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Sun Huanji on 2016/10/21.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }

}
