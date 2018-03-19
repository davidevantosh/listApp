//
//  AboutVC.swift
//  listApp
//
//  Created by David Tosh on 27/12/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AboutVC: UIViewController, UINavigationControllerDelegate, UITextViewDelegate, GADBannerViewDelegate {
    
    @IBOutlet weak var textView: UITextView!

    
    @IBOutlet weak var textLabelOne: UILabel!
    

    
    @IBOutlet weak var textLabelThree: UILabel!
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    
   

    var loadTheme: Bool = {
        Style.loadTheme()
        return true
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bannerView.isHidden = true
        bannerView.delegate = self
        
        Style.loadTheme()
        
        textView.textColor = Style.sectionHeaderTitleColor
        textLabelOne.textColor = Style.sectionHeaderTitleColor

        textLabelThree.textColor = Style.sectionHeaderTitleColor
        self.view.backgroundColor = Style.tableViewBackgroundColor

        textView.backgroundColor = Style.tableViewBackgroundColor

        let linkAttributes = [
            NSLinkAttributeName: NSURL(string: "http://www.david-tosh.com")!,
            NSForegroundColorAttributeName: UIColor.blue, NSFontAttributeName: UIFont(name: "Helvetica", size: 15.0)!] as [String : Any]
        
        
        let attributedString = NSMutableAttributedString(string: "david-tosh.com", attributes: [NSFontAttributeName: UIFont(name: "Helvetica", size: 15.0), NSForegroundColorAttributeName: Style.sectionHeaderTitleColor])
        
        // Set the 'click here' substring to be the link
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(0, 14))
       
        
        self.textView.delegate = self
        self.textView.attributedText = attributedString
        
      
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
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

    
    
    
    
    }
