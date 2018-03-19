//
//  TestViewController.swift
//  listApp
//
//  Created by David Tosh on 15/01/18.
//  Copyright © 2018 Solo. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var contentTextField: UITextField!
    
    
    let datePicker = UIDatePicker()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextField.becomeFirstResponder()
        
     
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: .selected)
        
        
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: 50 * 12, height: toolBar.frame.size.height)
        
        //scrollview on the toolbar
        
        
        
        
        
        
        
        
        
    //   var items = [UIBarButtonItem]()
        
        //list of toolbar
        
        //today (text)
        //tomorrow (text)
        //custom date (calendar) (icon)
        //calendar for reminder (icon)
        //pin (icon)
        
    let today =  UIBarButtonItem(title: "Date", style: .plain, target: nil, action: #selector(self.todayClicked))
    
    let spaceOne = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
    let tomorrow = UIBarButtonItem(title: "Tomorrow", style: .plain, target: self, action: #selector(self.tomorrowClicked))
        
    let spaceTwo =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
    let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
    let spaceThree = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
    let calendarOne = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add , target: self, action: #selector(self.calendarClicked))
       
    let spaceFour =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
       
    let calendarTwo =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add , target: self, action: #selector(self.calendarReminderClicked))
    
    let spaceFive =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
      
    let pin =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add , target: self, action: #selector(self.pinClicked))
        
    toolBar.setItems([today, spaceOne, tomorrow, spaceTwo, done, spaceThree, calendarOne, spaceFour, calendarTwo, spaceFive, pin], animated: false)
        
        
    
       
            
       
        //today
        
        //items.append (
     //      UIBarButtonItem(title: "Today", style: .plain, target: nil, action: nil)
    //    )
        
    //    items.append (
     //       UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    //   )
        
        // tomorrow
        
    //    items.append (
   //         UIBarButtonItem(title: "Tomorrow", style: .plain, target: self, action: #selector(self.tomorrowClicked))
    //    )
        
  //      items.append (
  //          UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
 //       )
        
        //custom date
        
  //      items.append (
  //          UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
  //          )
        
  //     items.append (
  //          UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
   //     )
        
        //reminder calendar
        
  //      items.append (
   //         UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add , target: self, action: #selector(self.calendarClicked))
  //      )
        
 //       items.append (
 //           UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
 //           )
        
        //calendar
        
  //      items.append (
  //          UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add , target: self, action: #selector(self.calendarClicked))
  //          )
        
 //       items.append (
 //           UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
 //       )
        
        //pin
        
  //      items.append (
 //           UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add , target: self, action: #selector(self.calendarClicked))
 //       )
        
        
    
        
   //     toolBar.setItems(items, animated: false)
        
        let scrollView = UIScrollView()
        scrollView.frame = toolBar.frame
        scrollView.bounds = toolBar.bounds
        scrollView.autoresizingMask = toolBar.autoresizingMask
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = toolBar.frame.size
        scrollView.addSubview(toolBar)
        
        contentTextField.inputAccessoryView = scrollView
        
        
        
        
        
     
        
    //    toolBar.setItems([doneButton], animated: false)
    //    toolBar.setItems([flexibleSpace], animated: false)
    //    toolBar.setItems([calendarButton], animated: false)
        
        

    //    contentTextField.inputAccessoryView = toolBar
        
        
        
        
        
        

        
    }
    
    func doneClicked() {
        
        view.endEditing(true)
    }
    
    
    
    @objc func todayClicked(_ sender: UIBarButtonItem) {
        
        if sender.style == .plain {
            sender.style = .done
        } else {
            sender.style = .plain
        }
        
        var _: Bool = (sender.style == .done)
        
    }
    
    @objc func tomorrowClicked(_ sender: UIBarButtonItem) {
    
        if sender.style == .plain {
            sender.style = .done
        } else {
            sender.style = .plain
        }
        
        var _: Bool = (sender.style == .done)
    
    }
    
    @IBAction func textboxpressed(_ sender: Any) {
    }
    
    
    
    @objc func calendarClicked(_sender: UIBarButtonItem) {
        
        view.endEditing(true)
        
        
        
      //  self.inputView?.becomeFirstResponder()
       // contentTextField.inputView = datePicker
        
        
       // view.reloadInputViews()
        
    }
    
    func calendarReminderClicked() {
        
        
        contentTextField.inputView = datePicker
        
        view.reloadInputViews()
        
    }
    
    func pinClicked() {
        
        
        contentTextField.inputView = datePicker
        
        view.reloadInputViews()
        
    }
 
  


}
