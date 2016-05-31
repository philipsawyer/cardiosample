//
//  ViewController.swift
//  CardIOSample
//
//  Created by Philip Sawyer on 5/26/16.
//  Copyright © 2016 Philip Sawyer. All rights reserved.
//

import UIKit

class DisplayVCViewController: UIViewController, CardIOPaymentViewControllerDelegate {
    
    var settingsDict : [String : AnyObject]!
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        self.title = "CardIO as ViewController"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.resultsLabel.hidden = true
        let defaultColor = UIColor.greenColor()
        self.settingsDict = ["locale" : "en", "backgroundBlur" : false, "guideColor" : defaultColor, "scanConfirmation" : false, "suppressScannedCardImage" : false, "scannedImageDuration" : 0.1, "hideCardIOLogo" : false, "disableManualEntryButtons" : false, "manualEntry" : false, "collectName" : true, "collectCVV" : true]
        
        CardIOUtilities.preload()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //print("\(self.settingsDict)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        print("userDidCancelPaymentViewController")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        self.resultsLabel.hidden = false
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@\nName: %@", (info.redactedCardNumber) ?? "", (info.expiryMonth) ?? "", (info.expiryYear) ?? "", (info.cvv) ?? "", (info.cardholderName) ?? "")
            print(str)
            self.resultsLabel.text = str as String
        } else {
            self.resultsLabel.text = "There were errors reading card"
        }
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func scanCard(sender: AnyObject) {
        let cardIOVC : CardIOPaymentViewController!
        if self.settingsDict["manualEntry"] as! Bool == false {
            print("scanning enabled")
            cardIOVC = CardIOPaymentViewController(paymentDelegate: self, scanningEnabled: true)
            cardIOVC.collectCardholderName = true
        } else {
            print("scanning NOT enabled")
            cardIOVC = CardIOPaymentViewController(paymentDelegate: self, scanningEnabled: false)
        }
        self.setUpViewController(cardIOVC)
        cardIOVC.modalPresentationStyle = .FormSheet
        presentViewController(cardIOVC, animated: true, completion: nil)
    }
    
    @IBAction func displaySettings(sender : AnyObject) {
        self.performSegueWithIdentifier("VCSettingsSegue", sender: self)
    }
    
    func setUpViewController(cardIOVC : CardIOPaymentViewController) {
        cardIOVC.languageOrLocale = self.getSetting("locale") as! String
        cardIOVC.disableBlurWhenBackgrounding = self.getSetting("backgroundBlur") as! Bool
        cardIOVC.guideColor = self.getSetting("guideColor") as! UIColor
        cardIOVC.suppressScanConfirmation = self.getSetting("scanConfirmation") as! Bool
        cardIOVC.suppressScannedCardImage = self.getSetting("suppressScannedCardImage") as! Bool
        cardIOVC.scannedImageDuration = self.getSetting("scannedImageDuration") as! CGFloat
        cardIOVC.hideCardIOLogo = self.getSetting("hideCardIOLogo") as! Bool
        cardIOVC.disableManualEntryButtons = self.getSetting("disableManualEntryButtons") as! Bool
        cardIOVC.collectCardholderName = self.getSetting("collectName") as! Bool
        cardIOVC.collectCVV = self.getSetting("collectCVV") as! Bool
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VCSettingsSegue" {
            let destinationViewController = segue.destinationViewController as! VCSettingsViewController
            destinationViewController.mainVC = self
        }
    }
    
    func getSetting(key : String) -> AnyObject {
        return settingsDict[key]!
    }
    
    func setSetting(key : String, setting : AnyObject) {
        self.settingsDict[key] = setting
    }
}

