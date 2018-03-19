//
//  Image+CoreDataProperties.swift
//  listApp
//
//  Created by David Tosh on 14/11/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toItem: Item?

}
