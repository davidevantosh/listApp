//
//  ItemDetailsVC.swift
//  listApp
//
//  Created by David Tosh on 15/11/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import GoogleMobileAds

class ItemDetailsVC: UITableViewController, UINavigationControllerDelegate, UITextFieldDelegate, GADBannerViewDelegate, UNUserNotificationCenterDelegate {
    
    
    
    
    
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tagLabel: UILabel!
    

    


    var titlefield = UITextField()
    var loadTheme: Bool = {
        Style.loadTheme()
        return true
    }()

    var itemToEdit: Item?
    var datePickerHidden = false
    var timePickerHidden = false
    
    let defaults = UserDefaults.standard
    let uuid = UUID().uuidString
   
    
    
    
    
    var bannerView = GADBannerView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        self.titleField.delegate = self
        self.detailsField.delegate = self
        
       self.tableView.tableFooterView = GADBannerView(frame: CGRect.zero)
       self.tableView.tableHeaderView = bannerView
        
        
        
        Style.loadTheme()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        if itemToEdit != nil {
            loadItemData()
            
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [(itemToEdit?.itemUUID)!])
            print("deleted uuid \(String(describing: itemToEdit?.itemUUID))")
            backButton.isEnabled = false
            backButton.tintColor = UIColor.clear
        }

        
        titleField.textColor = Style.sectionHeaderTitleColor
        detailsField.textColor = Style.sectionHeaderTitleColor
        detailLabel.textColor = Style.sectionHeaderTitleColor
        timeLabel.textColor = Style.sectionHeaderTitleColor
        tableView.backgroundColor = Style.tableViewBackgroundColor
        titleField.attributedPlaceholder = NSAttributedString(string: titleField.placeholder!, attributes: [NSForegroundColorAttributeName : Style.placeholderColor])
        detailsField.attributedPlaceholder = NSAttributedString(string: detailsField.placeholder!, attributes: [NSForegroundColorAttributeName : Style.placeholderColor])
        

        
        timePicker.setValue(Style.sectionHeaderTitleColor, forKeyPath: "textColor")
        datePicker.setValue(Style.sectionHeaderTitleColor, forKeyPath: "textColor")
        
        datePickerChanged()
        timePickerChanged()
       
        
        
        bannerView.backgroundColor = UIColor.orange
        
        bannerView.isHidden = true
        bannerView.delegate = self
        self.tableView.tableHeaderView?.isHidden = true
        
      
        
       }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        bannerView.isHidden = false
        self.tableView.tableHeaderView?.isHidden = false    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
        self.tableView.tableHeaderView?.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        let save = UserDefaults.standard
        if save.value(forKey: "purchase") == nil {
            
            bannerView.adUnitID = "ca-app-pub-5293595450581458/4691479259"
            bannerView.adSize = kGADAdSizeSmartBannerPortrait
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            
            
        } else {
            
            bannerView.isHidden = true
            self.tableView.tableHeaderView?.isHidden = true
            
        }
        
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = Style.cellBackgroundColor
        titleField.textColor = Style.sectionHeaderTitleColor
        detailsField.textColor = Style.sectionHeaderTitleColor
        detailLabel.textColor = Style.sectionHeaderTitleColor
        timeLabel.textColor = Style.sectionHeaderTitleColor
        detailsField.textColor = Style.sectionHeaderTitleColor
        tableView.backgroundColor = Style.tableViewBackgroundColor
        titleField.attributedPlaceholder = NSAttributedString(string: titleField.placeholder!, attributes: [NSForegroundColorAttributeName : Style.placeholderColor])
        detailsField.attributedPlaceholder = NSAttributedString(string: detailsField.placeholder!, attributes: [NSForegroundColorAttributeName : Style.placeholderColor])
        
        
      }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "backToMainVC", sender: self)
        
    }
    

    
    
    
    func datePickerChanged() {
        
        
        detailLabel.text = "Due \(DateFormatter.localizedString(from: datePicker.date, dateStyle: .long, timeStyle: .none))"
    }
    
    func timePickerChanged() {
        timeLabel.text = "Remind me on \(DateFormatter.localizedString(from: timePicker.date, dateStyle: .long, timeStyle: .short))"
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            toggleDatePicker()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            toggleTimePicker()
        }
        
    }
    
    
    func toggleDatePicker() {
        datePickerHidden = !datePickerHidden
        
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimePicker() {
        timePickerHidden = !timePickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 1 && indexPath.row == 1 {
            return 0
        } else {
            if timePickerHidden && indexPath.section == 2 && indexPath.row == 1 {
                return 0
            } else {
              
            return super.tableView(tableView, heightForRowAt: indexPath)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
             if response.actionIdentifier == "done" {
                 context.delete(itemToEdit!)
                 adt.saveContext()
    }
        completionHandler()
    }
    

    
    

    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        datePickerChanged()
    }
    
    @IBAction func timePickerChanged(_ sender: UIDatePicker) {
        timePickerChanged()
        
    }

    
    
  //saving the item
   
    
    @IBAction func continueButton(_ sender: AnyObject) {
        
        
            let uuid = UUID().uuidString
            
            let messageContent = titleField.text as? String!
        
        
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents(in: .current, from: timePicker.date)
            let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
            
            
            // notification text
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = messageContent!
            content.userInfo = ["UUID": uuid]
        
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
            
            //create notification request
            
            let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
            print("this is the uuid \(uuid)")
        
        
        
        if titleField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please add a title to your task", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else if titleField.text != "" {
            UNUserNotificationCenter.current().add(request) { (error) in
                
                if let errorPerforms = error {
                    print(errorPerforms.localizedDescription)
                    print("no good")
                } else {
                    print("Success")
                    print("this is the uuid \(uuid)")
                    
                }
                
                
            }
            
            var item: Item!
            
            let notificationID = uuid
            
            
            let notifID = notificationID
            
            if itemToEdit == nil {
                item = Item(context: context)
                
            } else {
                item = itemToEdit
            }
            
            
            if let title = titleField.text {
                item.title = title
            }
            
            if let details = detailsField.text {
                item.details = details
            }
            
            if let tag = tagLabel.text {
                item.tag = tag
            }
            
            item.itemUUID = notifID
            
            
            item.date = datePicker.date as NSDate?
            item.time = timePicker.date as NSDate?

            
            adt.saveContext()

            
            performSegue(withIdentifier: "backToMainVC", sender: self)
            


        }
        
       
       }
    
    //loading item data
    
    func loadItemData(){
        
        if let item = itemToEdit {
            titleField.text = item.title
            detailsField.text = item.details
            tagLabel.text = item.tag
            datePicker.date = item.date! as Date
            timePicker.date = item.time! as Date
            
        }
        
    }
    
    //hide keyboard when user touches outside the keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //presses return key
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        detailsField.resignFirstResponder()
        return true
    }
    
    // add image

    
}
    



    
    
    
    
    
    
    
    

