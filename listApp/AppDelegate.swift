//
//  AppDelegate.swift
//  listApp
//
//  Created by David Tosh on 6/11/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, NSFetchedResultsControllerDelegate {
    
    var window: UIWindow?
    let defaults = UserDefaults.standard
    
    var myViewController: ItemDetailsVC!
    
    var testVC: TestViewController!
    var itemToEdit: Item?
    var controller: NSFetchedResultsController<Item>!
    

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(accepted, error) in
            if !accepted {
               print("Notification access denied.")
            }
        }
        
        let action = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: [])
        let actionTwo = UNNotificationAction(identifier: "done", title: "Done", options: [.destructive])
        let category = UNNotificationCategory(identifier: "myCategory", actions: [action,actionTwo], intentIdentifiers: [], options: [])
    UNUserNotificationCenter.current().setNotificationCategories([category])
        
     
        return true
    }
    
    
    
    
    
    
    
 //
 //   func scheduleNotification(at date: Date) {
        
   //     let calendar = Calendar(identifier: .gregorian)
     //   let components = calendar.dateComponents(in: .current, from: date)
       // let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        //let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
 
        
        // notification text
       //let content = UNMutableNotificationContent()
        //content.title = "Reminder"
        //content.body = self.myViewController.titlefield.text!
        
        
        //if defaults.value(forKey: "switchOn") != nil {
          //  let soundSwitchOn: Bool = defaults.value(forKey: "switchOn") as! Bool
           //if soundSwitchOn == true {
             //  content.sound = UNNotificationSound.default()
            //}
            //else if soundSwitchOn == false {
              //  content.sound = nil
          // }
            
       // }
        //content.categoryIdentifier = "myCategory"
        
        //create notification request
        
       // let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        //UNUserNotificationCenter.current().delegate = self
       //UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    
        
        
    //}

    
        
  
    
    


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
     //   NotificationCenter.default.post(name: Notification.Name(rawValue: "TodoListShouldRefresh"), object: self)
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        application.applicationIconBadgeNumber = 0
        
        
        
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    self.saveContext()
    }
 
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "listApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
   
}
  //  extension AppDelegate: UNUserNotificationCenterDelegate {
 //   func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
  //      if response.actionIdentifier == "done" {
   //         context.delete(itemToEdit!)
   //         saveContext()
   //     }
  //  }
    
//}






let adt = UIApplication.shared.delegate as! AppDelegate
let context = adt.persistentContainer.viewContext
