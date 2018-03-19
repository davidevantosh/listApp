//
//  Style.swift
//  listApp
//
//  Created by David Tosh on 27/12/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import UIKit

    struct Style {
        
        static let availableThemes = ["defaultTheme", "blackTheme"]
        static func loadTheme(){
            let defaults = UserDefaults.standard
            if let name = defaults.string(forKey: "Theme"){
                
                if name == "defaultTheme"   { defaultTheme() }
                if name == "blackTheme" 	{ blackTheme() }
               
            }else{
                defaults.set("defaultTheme", forKey: "Theme")
                defaultTheme()
            }
        }
        
        
        static func switchTheme(){
            let defaults = UserDefaults.standard
            if let name = defaults.string(forKey: "switch"){
                
                if name == "switchOn"   { switchOn() }
                if name == "switchOff" 	{ switchOff() }
                
            }else{
                defaults.set("switchOn", forKey: "switch")
                switchOn()
            }
        }
        
        
        
        
        static var sectionHeaderTitleFont = UIFont(name: "Helvetica", size: 24)
        static var subsectionHeaderTitleFont = UIFont(name: "Roboto", size: 10)
        static var sectionHeaderTitleColor = UIColor.black
        static var subsectionHeaderTitleColor = UIColor.black
        static var sectionHeaderBackgroundColor = UIColor.gray
        static var cellBackgroundColor = UIColor.white
        static var navigationBarColor = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        static var navigationBarTextColor = [NSForegroundColorAttributeName:UIColor.white]
        static var navigationBarTintColor = UIColor.black
        static var tableViewBackgroundColor = UIColor.white
        static var tableviewSeperatorColor = UIColor.gray
        static var placeholderColor = UIColor.gray
        static var iconTint = UIColor.lightGray
        static var switchColor = UIColor(red:73.0/255.0, green: 153.0/255.0, blue: 218.0/255.0, alpha: 1.0)
        static var sectionHeaderColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        static var roundImageColor = UIColor.lightGray
        static var sectionHeaderTrueColor = UIColor.darkGray
        static var barButtonColor = UIColor.blue
        
        
        
        static func defaultTheme(){

        //font
        sectionHeaderTitleFont = UIFont(name: "Helvetica", size: 24)
        subsectionHeaderTitleFont = UIFont(name: "Roboto", size: 10)
        
            
        //font colour
        sectionHeaderTitleColor = UIColor.black
        subsectionHeaderTitleColor = UIColor.lightGray
        navigationBarTextColor = [NSForegroundColorAttributeName:UIColor.black]
            placeholderColor = UIColor.gray
            
        //background colour
        sectionHeaderBackgroundColor = UIColor.white
        navigationBarColor = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
            navigationBarTintColor = UIColor.black
        cellBackgroundColor = UIColor.white
            tableViewBackgroundColor = UIColor.white
            
        //seperator colour
        //UITableView.appearance().separatorColor = UIColor.gray
            tableviewSeperatorColor = UIColor.gray
       
        //icon color
            
        iconTint = UIColor.lightGray
            
        //switch color
            
            switchColor = UIColor(red:73.0/255.0, green: 153.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            
        //section header
        sectionHeaderColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
            
            roundImageColor = UIColor.lightGray
            
        sectionHeaderTrueColor = UIColor.darkGray
            
        //bar button
            
            barButtonColor = UIColor.blue
            
        }
        
        
        static func blackTheme(){
            
            //bar button
            
            barButtonColor = UIColor.white
            
            //
        
        //font
        sectionHeaderTitleFont = UIFont(name: "Helvetica", size: 19)
        subsectionHeaderTitleFont = UIFont(name: "Roboto", size: 10)
        
            
        //font colour
        sectionHeaderTitleColor = UIColor.white
        subsectionHeaderTitleColor = UIColor.white
        navigationBarTextColor = [NSForegroundColorAttributeName:UIColor.white]
            placeholderColor = UIColor.lightGray
            
        //background colour
            
        sectionHeaderBackgroundColor = UIColor.black
        cellBackgroundColor = UIColor(red: 47.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        navigationBarColor = UIColor(red: 35.0/255.0, green: 38.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        navigationBarTintColor = UIColor.white
        tableViewBackgroundColor = UIColor(red: 35.0/255.0, green: 38.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        
       // UITableView.appearance().separatorColor = UIColor.white
            tableviewSeperatorColor = UIColor.white
        
        //icon color
            
        iconTint = UIColor.lightGray
            
        //switch color
            
        switchColor = UIColor(red:73.0/255.0, green: 153.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            
        //section header color
        sectionHeaderColor = UIColor(red: 35.0/255.0, green: 38.0/255.0, blue: 38.0/255.0, alpha: 1.0)
            
            roundImageColor = UIColor.black
        
        sectionHeaderTrueColor = UIColor.white
        }
        
        static func switchOn(){
        }
        
        static func switchOff(){
        }
        
        
        
    }

