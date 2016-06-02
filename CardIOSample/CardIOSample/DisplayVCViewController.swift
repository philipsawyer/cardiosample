//
//  ViewController.swift
//  CardIOSample
//
//  Created by Philip Sawyer on 5/26/16.
//  Copyright © 2016 Philip Sawyer. All rights reserved.
//

import UIKit

struct Config {
    var locale: String
    var backgroundBlur: Bool
    var guideColor : UIColor
    var scanConfirmation : Bool
    var suppressScannedCardImage : Bool
    var scannedImageDuration : CGFloat
    var hideCardIOLogo : Bool
    var disableManualEntryButtons : Bool
    var manualEntry : Bool
    var collectName : Bool
    var collectCVV : Bool
}

class DisplayVCViewController: UIViewController, CardIOPaymentViewControllerDelegate {
    
    @IBOutlet weak var resultsLabel: UILabel!
    var config : Config!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        config = Config(locale: "en", backgroundBlur: false, guideColor: UIColor.greenColor(), scanConfirmation: false, suppressScannedCardImage: false, scannedImageDuration: 0.1, hideCardIOLogo: false, disableManualEntryButtons: false, manualEntry: false, collectName: true, collectCVV: true)
        
        title = "CardIO as ViewController"
        resultsLabel.hidden = true
        
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
        if config.manualEntry == false {
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
        cardIOVC.languageOrLocale = config.locale
        cardIOVC.disableBlurWhenBackgrounding = config.backgroundBlur
        cardIOVC.guideColor = config.guideColor
        cardIOVC.suppressScanConfirmation = config.scanConfirmation
        cardIOVC.suppressScannedCardImage = config.suppressScannedCardImage
        cardIOVC.scannedImageDuration = config.scannedImageDuration
        cardIOVC.hideCardIOLogo = config.hideCardIOLogo
        cardIOVC.disableManualEntryButtons = config.disableManualEntryButtons
        cardIOVC.collectCardholderName = config.collectName
        cardIOVC.collectCVV = config.collectCVV
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VCSettingsSegue" {
            let destinationViewController = segue.destinationViewController as! VCSettingsViewController
            destinationViewController.mainVC = self
        }
    }
    
}
