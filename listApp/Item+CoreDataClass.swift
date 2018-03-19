//
//  Item+CoreDataClass.swift
//  listApp
//
//  Created by David Tosh on 14/11/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
