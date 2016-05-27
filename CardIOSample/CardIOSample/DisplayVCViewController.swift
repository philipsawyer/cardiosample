//
//  ViewController.swift
//  CardIOSample
//
//  Created by Philip Sawyer on 5/26/16.
//  Copyright © 2016 Philip Sawyer. All rights reserved.
//

import UIKit

class DisplayVCViewController: UIViewController, CardIOPaymentViewControllerDelegate {
    
    var settingsHelper: VCSettingsHelper!

    override func viewDidLoad() {
        self.title = "CardIO as ViewController"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        settingsHelper = VCSettingsHelper()
        
        CardIOUtilities.preload()
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
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            print(str)
        }
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func scanCard(sender: AnyObject) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        self.setUpViewController(cardIOVC)
        cardIOVC.modalPresentationStyle = .FormSheet
        presentViewController(cardIOVC, animated: true, completion: nil)
    }
    
    @IBAction func displaySettings(sender : AnyObject) {
        self.performSegueWithIdentifier("VCSettingsSegue", sender: self)
    }
    
    func setUpViewController(cardIOVC : CardIOPaymentViewController) {
        cardIOVC.languageOrLocale = self.settingsHelper.getSetting("locale") as! String
        cardIOVC.disableBlurWhenBackgrounding = self.settingsHelper.getSetting("backgroundBlur") as! Bool
        cardIOVC.guideColor = self.settingsHelper.getSetting("guideColor") as! UIColor
        cardIOVC.suppressScanConfirmation = self.settingsHelper.getSetting("scanConfirmation") as! Bool
        cardIOVC.suppressScannedCardImage = self.settingsHelper.getSetting("suppressScannedCardImage") as! Bool
        cardIOVC.scannedImageDuration = self.settingsHelper.getSetting("scannedImageDuration") as! CGFloat
        cardIOVC.hideCardIOLogo = self.settingsHelper.getSetting("hideCardIOLogo") as! Bool
        cardIOVC.disableManualEntryButtons = self.settingsHelper.getSetting("disableManualEntryButtons") as! Bool
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VCSettingsSegue" {
            let destinationViewController = segue.destinationViewController as! VCSettingsViewController
            destinationViewController.settingsHelper = self.settingsHelper
        }
    }
}

