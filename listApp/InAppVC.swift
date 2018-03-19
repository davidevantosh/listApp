//
//  InAppVC.swift
//  listApp
//
//  Created by David Tosh on 11/06/17.
//  Copyright © 2017 Solo. All rights reserved.
//

import UIKit
import StoreKit
import GoogleMobileAds

class InAppVC: UIViewController, UINavigationBarDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate, GADBannerViewDelegate {

    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    @IBOutlet weak var bannerView: GADBannerView!

    @IBOutlet weak var textbox: UILabel!
    
    @IBOutlet weak var restoreButton: UIButton!
    
 
    var loadTheme: Bool = {
        Style.loadTheme()
        return true
    }()
    
    
    var product: SKProduct?
    var productID = "com.davidtosh.listapp.removeads1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Style.loadTheme()
        
        labelText.textColor = Style.sectionHeaderTitleColor
        textbox.textColor = Style.sectionHeaderTitleColor
        self.view.backgroundColor = Style.tableViewBackgroundColor
        
        
        bannerView.isHidden = true
        bannerView.delegate = self
        
        
        purchaseButton.isEnabled = false
        restoreButton.isEnabled = false
        SKPaymentQueue.default().add(self)
        getPurchaseInfo()
        
    purchaseButton.layer.cornerRadius  = 10
        restoreButton.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
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

    
    
    
    
    func getPurchaseInfo (){
        
        if SKPaymentQueue.canMakePayments() {
            
            let request = SKProductsRequest(productIdentifiers: NSSet(objects: self.productID) as! Set<String>)
            
            request.delegate = self
            request.start()
        } else {
            
            labelText.text = "Warning! Please enable in-app purchases in your settings"
            
        }
        
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        var products = response.products
        
        if (products.count == 0) {
            
            labelText.text = "Warning! Product not found!"
            
        } else {
            
            product = products[0]
           // labelText.text = product!.localizedTitle
            //productDescription.text = product!.localizedDescription  (add this in and as a new label along with a new lable for localized title)
            purchaseButton.isEnabled = true
            restoreButton.isEnabled = true
            
        }
        
        let invalids = response.invalidProductIdentifiers
        
        for product in invalids {
            
            print("product not found: \(product)")
            
        }
        
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
            
            case SKPaymentTransactionState.purchased:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                labelText.text = "Thank you"
                //productDescription.text = "the product has been purchased"
                purchaseButton.isEnabled = false
                restoreButton.isEnabled = false
                bannerView.isHidden = true
                
                let save = UserDefaults.standard
                save.set(true, forKey: "purchase")
                save.synchronize()
                
            case SKPaymentTransactionState.restored:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                labelText.text = "Restored!"
                purchaseButton.isEnabled = false
                restoreButton.isEnabled = false
                bannerView.isHidden = true
                
                let save = UserDefaults.standard
                save.set(true, forKey: "purchase")
                save.synchronize()

            
            case SKPaymentTransactionState.failed:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                labelText.text = "Warning, transaction failed"
                //productDescription.text = "the product has not been purchased"
                
            default:
                break
            }
            
            
        }
        
        
        
    }
    
    
    
 //  func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
 //       let save = UserDefaults.standard
  //      save.set(true, forKey: "purchase")
 //       save.synchronize()
        
    
        
  //  }
    
    
    
    @IBAction func purchasePressed(_ sender: Any) {
        
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        
    }
    
    @IBAction func restoreButtonPressed(_ sender: Any) {
        
        SKPaymentQueue.default().restoreCompletedTransactions()
       
        
    }

    
    
}
