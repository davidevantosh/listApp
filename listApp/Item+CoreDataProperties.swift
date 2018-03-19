//
//  Item+CoreDataProperties.swift
//  listApp
//
//  Created by David Tosh on 14/11/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var title: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var location: String?
    @NSManaged public var username: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var time: NSDate?
    @NSManaged public var category: String?
    @NSManaged public var itemUUID: String?
    @NSManaged public var tag: String?


}
