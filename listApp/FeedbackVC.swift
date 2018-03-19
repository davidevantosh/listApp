//
//  FeedbackVC.swift
//  listApp
//
//  Created by David Tosh on 28/12/16.
//  Copyright © 2016 Solo. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FeedbackVC: UIViewController, UINavigationControllerDelegate, UITextViewDelegate, GADBannerViewDelegate {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var textOne: UITextView!

    @IBOutlet weak var textThree: UITextView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    var loadTheme: Bool = {
        Style.loadTheme()
        return true
    }()
    
   // let url = URL(string: "mailto:davidevantosh@gmail.com")!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.isHidden = true
        bannerView.delegate = self
        
        Style.loadTheme()
        
        self.view.backgroundColor = Style.tableViewBackgroundColor
        
        topLabel.textColor = Style.sectionHeaderTitleColor
        textOne.textColor = Style.sectionHeaderTitleColor
        textThree.textColor = Style.sectionHeaderTitleColor
        
        self.view.backgroundColor = Style.tableViewBackgroundColor
        
        textOne.backgroundColor = Style.tableViewBackgroundColor
        textThree.backgroundColor = Style.tableViewBackgroundColor
        
        
      let linkAttributes = [
            NSLinkAttributeName: NSURL(string: "http://twitter.com/davidt0sh")!,
            NSForegroundColorAttributeName: UIColor.blue, NSFontAttributeName: UIFont(name: "Helvetica", size: 15.0)!] as [String : Any]
        
     
        let attributedString = NSMutableAttributedString(string: "@davidt0sh on Twitter", attributes: [NSFontAttributeName: UIFont(name: "Helvetica", size: 15.0), NSForegroundColorAttributeName: Style.sectionHeaderTitleColor])
        
        // Set the 'click here' substring to be the link
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(0, 10))
        
        
        self.textOne.delegate = self
        self.textOne.attributedText = attributedString
        
      let linkAttributesThree = [
            NSLinkAttributeName: NSURL(string: "http://www.david-tosh.com")!,
            NSForegroundColorAttributeName: UIColor.blue, NSFontAttributeName: UIFont(name: "Helvetica", size: 15.0)!] as [String : Any]
        
        
        let attributedStringThree = NSMutableAttributedString(string: "david-tosh.com", attributes: [NSFontAttributeName: UIFont(name: "Helvetica", size: 15.0), NSForegroundColorAttributeName: Style.sectionHeaderTitleColor])
        
        // Set the 'click here' substring to be the link
        attributedStringThree.setAttributes(linkAttributesThree, range: NSMakeRange(0, 14))
        
        
        self.textThree.delegate = self
        self.textThree.attributedText = attributedStringThree
        
        
    
    //    let emailLinkAttributes = [NSLinkAttributeName: NSURL(string: "mailto:davidevantosh@gmail.com")!,
      //                             NSForegroundColorAttributeName: UIColor.blue, NSFontAttributeName: UIFont(name: "Helvetica", size: 15.0)!] as [String : Any]
        
     //   let attributedStringTwo = NSMutableAttributedString(string: "davidevantosh@gmail.com on email", attributes: [NSFontAttributeName: UIFont(name: "Helvetica", size: 15.0), NSForegroundColorAttributeName: Style.sectionHeaderTitleColor])
        
      //  attributedStringTwo.setAttributes(emailLinkAttributes, range: NSMakeRange(0, 23))
        
     //   self.textTwo.delegate = self
     //   self.textTwo.attributedText = attributedStringTwo
        
        
        
    }

    private func textOne(_ textOne: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    private func textThree(_ textThree: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    //private func textTwo(_ textTwo: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
      //  UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
      //      print("Open \(self.url): \(success)")
     //   })
      //  return true
   // }
    
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
