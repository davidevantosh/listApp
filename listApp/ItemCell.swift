//
//  ItemCell.swift
//  listApp
//
//  Created by David Tosh on 14/11/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import UIKit
import CoreData


class ItemCell: UITableViewCell, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    


    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var view: UIView!


    var controller: NSFetchedResultsController<Item>!

    


    func configureCell(item: Item) {
        
        let dateCell = item.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        location.text = "Due: \(dateFormatter.string(from: dateCell! as Date))"
        title.text = item.title
        
        title.textColor = Style.sectionHeaderTitleColor
        location.textColor = Style.subsectionHeaderTitleColor
        
        if let date = dateFormatter.date(from: dateFormatter.string(from: dateCell! as Date)){
            
            if date < Date() {
                location.textColor = UIColor(red:73.0/255.0, green: 153.0/255.0, blue: 218.0/255.0, alpha: 1.0)
                print("Before now")
            } else {
                location.textColor = Style.subsectionHeaderTitleColor
                print("After now")
            }
        }
        
    }
    

}

    
    
    

    

