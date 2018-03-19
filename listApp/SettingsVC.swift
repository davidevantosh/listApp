//
//  SettingsVC.swift
//  listApp
//
//  Created by David Tosh on 27/12/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import GoogleMobileAds


class SettingsVC: UITableViewController, UINavigationControllerDelegate, GADBannerViewDelegate {
    
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var inAppLabel: UILabel!
    @IBOutlet weak var removeAdsLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var soundLabel: UILabel!
    
    var refresher: UIRefreshControl!
    
    
    var soundSwitchOn = Bool()
    var soundSwitchOff = Bool()
    

    var darkOn = Bool()
    var lightOn = Bool()
    
  
    
    
    
   // let url = URL(string: "http://www.stuff.co.nz")!
    
    let url = URL(string: "itms-apps://itunes.apple.com/app/id1247241271")!
    
    let defaults = UserDefaults.standard
 
    //var bannerView = GADBannerView(frame: CGRect(origin: CGPoint(x: 0, y: 553), size: CGSize(width: 375, height: 50)))
    var bannerView = GADBannerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = Style.navigationBarTextColor
        } else {

        }
        
        self.refreshControl = nil
     
    
        Style.loadTheme()
        Style.switchTheme()
        

        
       darkModeLabel.textColor = Style.sectionHeaderTitleColor
        inAppLabel.textColor = Style.sectionHeaderTitleColor
        removeAdsLabel.textColor = Style.sectionHeaderTitleColor
        rateLabel.textColor = Style.sectionHeaderTitleColor
        aboutLabel.textColor = Style.sectionHeaderTitleColor
        soundLabel.textColor = Style.sectionHeaderTitleColor
        feedbackLabel.textColor = Style.sectionHeaderTitleColor
        navigationController?.navigationBar.barTintColor = Style.navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = Style.navigationBarTextColor
        navigationController?.navigationBar.tintColor = Style.navigationBarTintColor
        
       // UITableView.appearance().separatorColor = Style.tableviewSeperatorColor
        
       self.tableView.backgroundColor = Style.tableViewBackgroundColor
       
        
        soundSwitch.onTintColor = Style.switchColor
        themeSwitch.onTintColor = Style.switchColor
        
        
        let blackTheme = UserDefaults.standard
        
        darkOn = blackTheme.bool(forKey: "blackTheme")
        
        let defaultTheme = UserDefaults.standard
        
        lightOn = defaultTheme.bool(forKey: "defaultTheme")
        
        let switchOn = UserDefaults.standard
        let switchOff = UserDefaults.standard
        
        soundSwitchOn = switchOn.bool(forKey: "switchOn")
        soundSwitchOff = switchOff.bool(forKey: "switchOff")

 
        if (darkOn == true) {
            themeSwitch.isOn = true
            Style.blackTheme()
            
            }
        
        if (lightOn == true) {
            themeSwitch.isOn = false
            Style.defaultTheme()
            
        }
        
        if (soundSwitchOn == true) {
            soundSwitch.isOn = true
            Style.switchOn()
        }
        
        if (soundSwitchOff == true) {
            soundSwitch.isOn = false
            Style.switchOff()
        }
        
        
        Style.loadTheme()
        Style.switchTheme()
        
        refresher = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refresher.addTarget(self, action: #selector(getter: SettingsVC.themeSwitch), for: UIControlEvents.valueChanged)
        refresher.addTarget(self, action: #selector(getter: SettingsVC.soundSwitch), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refresher)
        
        bannerView.backgroundColor = UIColor.orange
        
        self.tableView.tableHeaderView = bannerView
        bannerView.isHidden = true
        self.tableView.tableHeaderView?.isHidden = true
        bannerView.delegate = self
        
       // self.tableView?.addSubview(bannerView)
        
        
        
        
        
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        bannerView.isHidden = false
        self.tableView.tableHeaderView?.isHidden = false
    }
    
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
            removeAdsLabel.text = "Purchased!"
            
            
        }
        
    }

  
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = Style.cellBackgroundColor
        darkModeLabel.textColor = Style.sectionHeaderTitleColor
        inAppLabel.textColor = Style.sectionHeaderTitleColor
        removeAdsLabel.textColor = Style.sectionHeaderTitleColor
        rateLabel.textColor = Style.sectionHeaderTitleColor
        aboutLabel.textColor = Style.sectionHeaderTitleColor
        feedbackLabel.textColor = Style.sectionHeaderTitleColor
        

        soundLabel.textColor = Style.sectionHeaderTitleColor
        navigationController?.navigationBar.barTintColor = Style.navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = Style.navigationBarTextColor
        navigationController?.navigationBar.tintColor = Style.navigationBarTintColor
        
        
       // UITableView.appearance().separatorColor = Style.tableviewSeperatorColor
        
        soundSwitch.onTintColor = Style.switchColor
        themeSwitch.onTintColor = Style.switchColor
        
        self.tableView.backgroundColor = Style.sectionHeaderColor
        
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = Style.sectionHeaderTrueColor
    }
    
    
    @IBAction func themeSwitched(_ sender: AnyObject) {
        
        
        if themeSwitch.isOn == false {
            
            let defaultTheme = UserDefaults.standard
            defaultTheme.set(true, forKey: "defaultTheme")
            
            let blackTheme = UserDefaults.standard
            blackTheme.set(false, forKey: "blackTheme")
            
            let defaults = UserDefaults.standard
            defaults.set("defaultTheme", forKey: "Theme")
            
            Style.defaultTheme()
            
            
        } else {
            if themeSwitch.isOn == true {
                
                let blackTheme = UserDefaults.standard
                blackTheme.set(true, forKey: "blackTheme")
                
                
                let defaultTheme = UserDefaults.standard
                defaultTheme.set(false, forKey: "defaultTheme")
                
                let defaults = UserDefaults.standard
                defaults.set("blackTheme", forKey: "Theme")
                
                Style.blackTheme()
                
                
            }
        }
        
        tableView.reloadData()
        
        refresher.endRefreshing()
        
        navigationController?.navigationBar.barTintColor = Style.navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = Style.navigationBarTextColor
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = Style.navigationBarTextColor
        } else {
            
        }
      
    }
    

    @IBAction func switchPressed(_ sender: AnyObject) {
       
        if soundSwitch.isOn == true {
            let switchOn = UserDefaults.standard
            switchOn.set(true, forKey: "switchOn")
            
            let switchOff = UserDefaults.standard
            switchOff.set(false, forKey: "switchOff")
            
            
            let defaults = UserDefaults.standard
            defaults.set("switchOn", forKey: "switch")
            
            Style.switchOn()
            
        } else {
        if soundSwitch.isOn == false {
            let switchOff = UserDefaults.standard
            switchOff.set(true, forKey: "switchOff")
            
            let switchOn = UserDefaults.standard
            switchOn.set(false, forKey: "switchOn")
            
            let defaults = UserDefaults.standard
            defaults.set("switchOff", forKey: "switch")
            
            Style.switchOff()
            
            }
        
        }
        
        tableView.reloadData()
        
        refresher.endRefreshing()
    }
    
    
    
    
    
    @IBAction func rateButtonPressed(_ sender: AnyObject) {
        if #available(iOS 10, *) {
        UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
            print("Open \(self.url): \(success)")
        })
       
        }
}
}
