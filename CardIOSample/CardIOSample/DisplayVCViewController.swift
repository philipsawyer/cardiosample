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
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "CardIO as ViewController"
        resultsLabel.hidden = true
        let defaultColor = UIColor.greenColor()
        settingsDict = ["locale" : "en", "backgroundBlur" : false, "guideColor" : defaultColor, "scanConfirmation" : false, "suppressScannedCardImage" : false, "scannedImageDuration" : 0.1, "hideCardIOLogo" : false, "disableManualEntryButtons" : false, "manualEntry" : false, "collectName" : true, "collectCVV" : true]
        
        CardIOUtilities.preload()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //print("\(settingsDict)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        print("userDidCancelPaymentViewController")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        resultsLabel.hidden = false
        if let info = cardInfo {
            let str = "Received card info.\n Number: \(info.redactedCardNumber)\n expiry: \(info.expiryMonth):\(info.expiryYear) cvv: \(info.cvv)\nName: \(info.cardholderName)"
            print(str)
            resultsLabel.text = str
        } else {
            resultsLabel.text = "There were errors reading card"
        }
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func scanCard(sender: AnyObject) {
        let cardIOVC : CardIOPaymentViewController!
        if settingsDict["manualEntry"] as! Bool == false {
            print("scanning enabled")
            cardIOVC = CardIOPaymentViewController(paymentDelegate: self, scanningEnabled: true)
            cardIOVC.collectCardholderName = true
        } else {
            print("scanning NOT enabled")
            cardIOVC = CardIOPaymentViewController(paymentDelegate: self, scanningEnabled: false)
        }
        setUpViewController(cardIOVC)
        cardIOVC.modalPresentationStyle = .FormSheet
        presentViewController(cardIOVC, animated: true, completion: nil)
    }
    
    @IBAction func displaySettings(sender : AnyObject) {
        performSegueWithIdentifier("VCSettingsSegue", sender: self)
    }
    
    func setUpViewController(cardIOVC : CardIOPaymentViewController) {
        cardIOVC.languageOrLocale = getSetting("locale") as! String
        cardIOVC.disableBlurWhenBackgrounding = getSetting("backgroundBlur") as! Bool
        cardIOVC.guideColor = getSetting("guideColor") as! UIColor
        cardIOVC.suppressScanConfirmation = getSetting("scanConfirmation") as! Bool
        cardIOVC.suppressScannedCardImage = getSetting("suppressScannedCardImage") as! Bool
        cardIOVC.scannedImageDuration = getSetting("scannedImageDuration") as! CGFloat
        cardIOVC.hideCardIOLogo = getSetting("hideCardIOLogo") as! Bool
        cardIOVC.disableManualEntryButtons = getSetting("disableManualEntryButtons") as! Bool
        cardIOVC.collectCardholderName = getSetting("collectName") as! Bool
        cardIOVC.collectCVV = getSetting("collectCVV") as! Bool
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
        settingsDict[key] = setting
    }
}

