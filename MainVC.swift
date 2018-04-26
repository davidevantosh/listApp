//
//  MainVC.swift
//  listApp
//
//  Created by David Tosh on 14/11/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import UIKit
import CoreData
import UIKit
import GoogleMobileAds
import UserNotifications
import Intents




class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, GADBannerViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet var bannerView: GADBannerView!
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    
     var loadTheme: Bool = {
        Style.loadTheme()
        Style.switchTheme()
        return true
    }()


    var controller: NSFetchedResultsController<Item>!
    

    
    var menuShowing = false
    var showStatusBar = true
    
    override var prefersStatusBarHidden: Bool {
        
        if showStatusBar == true {
            
            //does not prefer status bar hidden
            print("does not prefer status bar hidden")
            return false
            
        } else {
            
            //does prefer status bar hidden
            print("does prefer status bar hidden")
            return true
            
        }
    }
    
  
   override func viewDidLoad() {
        super.viewDidLoad()
    
 
    

    
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
    swipeLeft.direction = .left
    self.view.addGestureRecognizer(swipeLeft)
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
    swipeRight.direction = .right
    self.view.addGestureRecognizer(swipeRight)
    
    
    
    
    //big navigation bar text
    
   // if #available(iOS 11.0, *) {
    //    navigationController?.navigationBar.prefersLargeTitles = true
   //     navigationController?.navigationBar.largeTitleTextAttributes = Style.navigationBarTextColor
   // } else {
        
  //  }
    
    
    bannerView.isHidden = true
    bannerView.delegate = self
    
  //  NotificationCenter.default.addObserver(self, selector: #selector(MainVC.refreshList), name: NSNotification.Name(rawValue: "TodoListShouldRefresh"), object: nil)
    
    
    
        Style.loadTheme()
    

        navigationController?.navigationBar.barTintColor = Style.navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = Style.navigationBarTextColor
        navigationController?.navigationBar.tintColor = Style.navigationBarTintColor
    
    
        self.tableView.backgroundColor = Style.tableViewBackgroundColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemCell.self, forCellReuseIdentifier: "cell")
        
        self.view.superview?.addSubview(bannerView)
        bannerView.frame.size.height = 50
    
    
    tableView.layer.shadowOpacity = 1
    tableView.layer.shadowRadius = 10
    
    
    

        attemptFetch()
    }
    


    
    //ads
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        bannerView.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
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
            
        }

    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = Style.cellBackgroundColor
        navigationController?.navigationBar.barTintColor = Style.navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = Style.navigationBarTextColor
        navigationController?.navigationBar.tintColor = Style.navigationBarTintColor
        
    }
    
    
  
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        cell.selectionStyle = .none
        
     //   _ = todoItems[(indexPath as NSIndexPath).row] as ItemID
        
     //   let todoItem = todoItems[(indexPath as NSIndexPath).row] as ItemID
       

        
        return cell
    }
    

    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
     
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    
    func toDoItemEdit(_ editItem: Item) {
        if let objs = controller.fetchedObjects, objs.count > 0 {
            performSegue(withIdentifier: "ItemDetailsVC", sender: objs)
        
        }
        
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ItemDetailsVC" {
            if let destination = segue.destination as? ItemDetailsVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects

        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        
        return 70
        
    }
    
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        
        
        do {
           try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    
    
    
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
            
        case.insert:
                if let indexPath = newIndexPath {
                    
                    tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
            }
            }
    
 // func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   //  if editingStyle == .delete {
        
   //     let delete = UITableViewRowAction(style: .default, title: "glyphicons-17-bin") { action, index in
        
    //    }
        
        
     //   context.delete((controller.fetchedObjects?[indexPath.row])!)
        
     //   ad.saveContext()
        
    //    delete.backgroundColor = UIColor.green
    
    //    attemptFetch()
            
            
            
  //   } else if editingStyle == .none {
        
        
        
        
 //   }
    
    
    fileprivate func whitespaceString(font: UIFont = UIFont.systemFont(ofSize: 15), width: CGFloat) -> String {
        let kPadding: CGFloat = 20
        let mutable = NSMutableString(string: "")
        let attribute = [NSFontAttributeName: font]
        while mutable.size(attributes: attribute).width < width - (2 * kPadding) {
            mutable.append(" ")
        }
        return mutable as String
    }

    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
      
        
        let kCellActionWidth = CGFloat(70.0)
        let kCellHeight = tableView.frame.size.height
        let whitespace = whitespaceString(width: kCellActionWidth)
        
        let deleteAction = UITableViewRowAction(style: .`default`, title: whitespace) {_,_ in
         context.delete((self.controller.fetchedObjects?[indexPath.row])!)
            
            let center = UNUserNotificationCenter.current()
            
            center.removePendingNotificationRequests(withIdentifiers: [(self.controller.fetchedObjects?[indexPath.row].itemUUID)!])
            print("deleted uuid \(String(describing: self.controller.fetchedObjects?[indexPath.row].itemUUID))")
         
            
           // center.removePendingNotificationRequests(withIdentifiers: [(itemToEdit?.itemUUID)!])
     
//center.removePendingNotificationRequests(withIdentifiers: self.controller.fetchedObjects.)
            
     //   let item = self.todoItems.remove(at: index)
            
     //   TodoList.sharedInstance.removeItem(item)
            
                      self.navigationItem.leftBarButtonItem!.isEnabled = true // we definitely have under 64 notifications scheduled now, make sure 'add' button is enabled
            
            
            adt.saveContext()
            self.attemptFetch()
            
        }
        
        let view = UIView(frame: CGRect(x: tableView.frame.size.width-70, y: 0, width: 70, height: kCellHeight))
        view.backgroundColor = UIColor(red:73.0/255.0, green: 153.0/255.0, blue: 218.0/255.0, alpha: 1.0) // background color of view
        let imageView = UIImageView(frame: CGRect(x: 17, y: 17.5, width: 35, height: 35))
        
        
        imageView.image = UIImage(named: "glyphicons-199-ok-circle")
        imageView.tintColor = UIColor.white
        view.addSubview(imageView)
        let image = view.image()
        
        deleteAction.backgroundColor = UIColor(patternImage: image)
        
        let editAction = UITableViewRowAction(style: .`default`, title: whitespace) {_,_ in
            if let objs = self.controller.fetchedObjects, objs.count > 0 {
                let item = objs[indexPath.row]
                self.performSegue(withIdentifier: "ItemDetailsVC", sender: item)
            }

        
        }
        
        let viewTwo = UIView(frame: CGRect(x: tableView.frame.size.width-140, y: 0, width: 70, height: kCellHeight))
        viewTwo.backgroundColor = UIColor(red:73.0/255.0, green: 153.0/255.0, blue: 218.0/255.0, alpha: 1.0) // background color of view
        let imageViewTwo = UIImageView(frame: CGRect(x: 17, y: 17.5, width: 40, height: 35))
    
        
        imageViewTwo.image = UIImage(named: "glyphicons-151-edit.png")
        imageViewTwo.tintColor = UIColor.white
        viewTwo.addSubview(imageViewTwo)
        let imageTwo = viewTwo.image()
        
        editAction.backgroundColor = UIColor(patternImage: imageTwo)
        
        
        return [deleteAction, editAction]
        
        
           
            
        }
    
    @IBAction func showMenu(_ sender: Any) {
        if (menuShowing) {
            leadingConstraint.constant = 0
            trailingConstraint.constant = 0
            
            showStatusBar = true
            
            UIView.animate(withDuration: 0.3){self.setNeedsStatusBarAppearanceUpdate()}
       
        } else {
        leadingConstraint.constant = 100
        trailingConstraint.constant = -100
            
            showStatusBar = false
            
            UIView.animate(withDuration: 0.3){self.setNeedsStatusBarAppearanceUpdate()}
            
            
        }
        
        UIView.animate(withDuration: 0.3, animations: { self.view.layoutIfNeeded()})
        setNeedsStatusBarAppearanceUpdate()
        
        menuShowing = !menuShowing
        showStatusBar = !showStatusBar
    }
    
    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.left {
            leadingConstraint.constant = 0
            trailingConstraint.constant = 0
            
            showStatusBar = true
            UIView.animate(withDuration: 0.3){self.setNeedsStatusBarAppearanceUpdate()}
            
        } else {
            
            if gesture.direction == UISwipeGestureRecognizerDirection.right {
            
            leadingConstraint.constant = 200
            trailingConstraint.constant = -200
            
            showStatusBar = false
            UIView.animate(withDuration: 0.3){self.setNeedsStatusBarAppearanceUpdate()}
        }
        }
            
            
          //  UIView.animate(withDuration: 0.3, animations: { self.view.layoutIfNeeded()})
          //  UIStatusBarAnimation.slide
         //   setNeedsStatusBarAppearanceUpdate()
        
            menuShowing = !menuShowing
            showStatusBar = !showStatusBar
        }
    

    
    
    
    //remove limits on notifications
    
  //  func refreshList() {
  ///      todoItems = TodoList.sharedInstance.allItems()
   //     if(todoItems.count >= 64) {
   //         self.navigationItem.leftBarButtonItem!.isEnabled = false //disabling add button
   //     }
   //     tableView.reloadData()
   // }
        
            
    }
    
        
   
    
    
    





