//
//  TestViewController.swift
//  listApp
//
//  Created by David Tosh on 15/01/18.
//  Copyright © 2018 Solo. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class TestViewController: UIViewController {
    
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak var centerPopupContraint: NSLayoutConstraint!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var fullScreenButton: UIButton!
    @IBOutlet weak var alarmView: UIView!
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var centerAlarmPopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var alarmNavBar: UINavigationBar!
    @IBOutlet weak var alarmPicker: UIDatePicker!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
  //  let datePicker = UIDatePicker()
    
    //core data
    var itemToEdit: Item?
    let uuid = UUID().uuidString
    let defaults = UserDefaults.standard
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().isTranslucent = false
        
        calendarView.layer.cornerRadius = 10
        calendarView.layer.masksToBounds = true
        
        alarmView.layer.cornerRadius = 10
        alarmView.layer.masksToBounds = true
        
        contentTextField.becomeFirstResponder()
        
     
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.darkGray], for: .selected)
        
        
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: 50 * 8, height: toolBar.frame.size.height)
        
        //core data
        
        if itemToEdit != nil {
            loadItemData()
            
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [(itemToEdit?.itemUUID)!])
            print("deleted uuid \(String(describing: itemToEdit?.itemUUID))")
        }
        
        //notification
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
     
        datePickerChanged()
        alarmPickerChanged()
        
        
    let done =  UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(self.doneClicked))
        done.tintColor = UIColor.darkGray
    
    let spaceOne = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spaceOne.width = 50
        
    //calendar item
        
    let calendar = UIBarButtonItem(image: UIImage(named:"glyphicons-46-calendar"), style: .plain, target: self, action: #selector(self.calendarClicked))
        calendar.tintColor = UIColor.darkGray
        
    let spaceTwo =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spaceTwo.width = 50
     
    //alarm item
        
    let alarm = UIBarButtonItem(image: UIImage(named:"glyphicons-54-alarm"), style: .plain, target: self, action: #selector(self.alarmClicked))
        alarm.tintColor = UIColor.darkGray
        
    let spaceThree = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spaceThree.width = 50
        
        //star item
        
    let star = UIBarButtonItem(image: UIImage(named:"glyphicons-50-star"),style: .plain, target: self, action: #selector(self.starClicked))
        star.tintColor = UIColor.darkGray
        
        
        
    toolBar.setItems([done, spaceOne, calendar, spaceTwo, alarm, spaceThree, star], animated: false)
        
        
        let scrollView = UIScrollView()
        scrollView.frame = toolBar.frame
        scrollView.bounds = toolBar.bounds
        scrollView.autoresizingMask = toolBar.autoresizingMask
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = toolBar.frame.size
        scrollView.addSubview(toolBar)
        
        contentTextField.inputAccessoryView = scrollView
        
    }
    
    
    
    func datePickerChanged() {
    }
    
    func alarmPickerChanged() {
    }
    
    
    func alarmClicked(_ sender: UIBarButtonItem) {
        centerAlarmPopupConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.fullScreenButton.alpha = 0.3
            self.contentTextField.resignFirstResponder()
        })
    }
    
    @IBAction func alarmButton(_ sender: Any) {
        centerAlarmPopupConstraint.constant = -600
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.fullScreenButton.alpha = 0
            self.contentTextField.becomeFirstResponder()
        })
        
    }
    
    @IBAction func alarmPopupClose(_ sender: Any) {
        centerAlarmPopupConstraint.constant = -600
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.fullScreenButton.alpha = 0
            self.contentTextField.becomeFirstResponder()
        })
    
    }
    

    
    @objc func calendarClicked(_ sender: UIBarButtonItem) {
        
        var _: Bool = (sender.style == .done)
        
        centerPopupContraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.fullScreenButton.alpha = 0.3
            self.contentTextField.resignFirstResponder()
            })
        
        
    
    }
    
    @IBAction func calendarPopupSubmit(_ sender: Any) {
        centerPopupContraint.constant = -600
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.fullScreenButton.alpha = 0
            self.contentTextField.becomeFirstResponder()
        })
        
        
    }
    
    @IBAction func calendarPopupClose(_ sender: Any) {
        centerPopupContraint.constant = -600
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.fullScreenButton.alpha = 0
            self.contentTextField.becomeFirstResponder()
        })
    }
    
    
    
    @IBAction func textboxpressed(_ sender: Any) {
    }
    
    
    
   @objc func starClicked(_ sender: UIBarButtonItem) {
    
    if sender.style == .plain {
    sender.style = .done
        sender.tintColor = UIColor.yellow
    } else {
    sender.style = .plain
        sender.tintColor = UIColor.darkGray
    }
    
    var _: Bool = (sender.style == .done)
    
   }
    
  
    
    
    
    func calendarReminderClicked() {
        
        
        contentTextField.inputView = datePicker
        
        view.reloadInputViews()
        
    }
    
    func pinClicked() {
        
        
        contentTextField.inputView = datePicker
        
        view.reloadInputViews()
        
    }
    
    //CORE DATA
    
    func scheduleNotification() {
        
        let uuid = UUID().uuidString
        let messageContent = contentTextField.text as? String!
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: alarmPicker.date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        //notification text
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = messageContent!
        content.userInfo = ["UUID": uuid]
        content.badge = 1
        content.categoryIdentifier = "myCategory"
        
        print("this is the userinfo \(["UUID": uuid])")
        
        if defaults.value(forKey: "switchOn") != nil {
            let soundSwitchOn: Bool = defaults.value(forKey: "switchOn") as! Bool
            if soundSwitchOn == true {
                content.sound = UNNotificationSound.default()
            }
            else if soundSwitchOn == false {
                content.sound = nil
            }
            
        }
        
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        print("this is the uuid \(uuid)")
        
        //warning message
        
        if contentTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please add a title to your task", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else if contentTextField.text != "" {
            
            UNUserNotificationCenter.current().add(request) { (error) in
                
                if let errorPerforms = error {
                    print(errorPerforms.localizedDescription)
                    print("no good")
                } else {
                    print("Success")
                    print("this is the uuid \(uuid)")
                    
                }
                
                
            }
        }
    }
    
    @objc func doneClicked(_ sender: UIBarButtonItem) {
        
        scheduleNotification()
        
        //bar button
        
        if sender.style == .plain {
            sender.style = .done
        } else {
            sender.style = .plain
        }
        
        var _: Bool = (sender.style == .done)
        

        //SAVE
        
        var item: Item!
        
        let notificationID = uuid
        let notifID = notificationID
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        if let title = contentTextField.text {
            item.title = title
        }
        
        item.itemUUID = notifID
        
        item.date = datePicker.date as NSDate?
        item.time = alarmPicker.date as NSDate?
        
        adt.saveContext()
        performSegue(withIdentifier: "backToMain", sender: self)
        
    
        
        
    }
        
    
    func loadItemData() {
        if let item = itemToEdit {
            contentTextField.text = item.title
            datePicker.date = item.date! as Date
            alarmPicker.date = item.time! as Date
    
            
            
        }
        
    }


}
