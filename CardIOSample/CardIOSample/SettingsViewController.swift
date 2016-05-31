//
//  VCSettingsViewController.swift
//  CardIOSample
//
//  Created by Philip Sawyer on 5/27/16.
//  Copyright © 2016 Philip Sawyer. All rights reserved.
//

import UIKit

class VCSettingsViewController: UIViewController, UITextFieldDelegate {
    
    var mainVC : DisplayVCViewController!

    @IBOutlet weak var localeTextField: UITextField!
    @IBOutlet weak var backgroundBlurSwitch: UISwitch!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var confirmScanInfoSwitch: UISwitch!
    @IBOutlet weak var confirmWithManualSwitch: UISwitch!
    @IBOutlet weak var scannedImageDurationTextField: UITextField!
    @IBOutlet weak var manualOnlySwitch: UISwitch!
    @IBOutlet weak var hideCardIOLabel: UISwitch!
    @IBOutlet weak var disableManualEntryButtonsSwitch: UISwitch!
    @IBOutlet weak var collectCVVSwitch: UISwitch!
    @IBOutlet weak var collectNameSwtich: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        
        self.localeTextField.text = mainVC.getSetting("locale") as? String
        self.backgroundBlurSwitch.on = mainVC.getSetting("backgroundBlur") as! Bool
        self.colorButton.setTitle((mainVC.getSetting("guideColor") as! UIColor).description, forState: .Normal)
        self.confirmScanInfoSwitch.on = mainVC.getSetting("scanConfirmation") as! Bool
        self.confirmWithManualSwitch.on = mainVC.getSetting("suppressScannedCardImage") as! Bool
        self.scannedImageDurationTextField.text = "\((mainVC.getSetting("scannedImageDuration") as! CGFloat))"
        self.hideCardIOLabel.on = mainVC.getSetting("hideCardIOLogo") as! Bool
        self.disableManualEntryButtonsSwitch.on = mainVC.getSetting("disableManualEntryButtons") as! Bool
        self.manualOnlySwitch.on = mainVC.getSetting("manualEntry") as! Bool
        self.collectCVVSwitch.on = mainVC.getSetting("collectCVV") as! Bool
        self.collectNameSwtich.on = mainVC.getSetting("collectName") as! Bool
    }
    
    
    @IBAction func changeColorGuide(sender: AnyObject) {
        let actionsheet = UIAlertController(title: "Select Color", message: nil, preferredStyle: .ActionSheet)
        let orangeAction = UIAlertAction(title: "Orange", style: .Default) { action -> Void in
            self.mainVC.settingsDict["guideColor"] = UIColor.orangeColor()
            self.updateColorTextField()
        }
        let redAction = UIAlertAction(title: "Red", style: .Default) { action -> Void in
            self.mainVC.settingsDict["guideColor"] = UIColor.redColor()
            self.updateColorTextField()
        }
        let blueAction = UIAlertAction(title: "Blue", style: .Default) { action -> Void in
            self.mainVC.settingsDict["guideColor"] = UIColor.blueColor()
            self.updateColorTextField()
        }
        let yellowAction = UIAlertAction(title: "Yellow", style: .Default) { action -> Void in
            self.mainVC.settingsDict["guideColor"] = UIColor.yellowColor()
            self.updateColorTextField()
        }
        let greenAction = UIAlertAction(title: "Green", style: .Default) { action -> Void in
            self.mainVC.settingsDict["guideColor"] = UIColor.greenColor()
            self.updateColorTextField()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionsheet.addAction(orangeAction)
        actionsheet.addAction(redAction)
        actionsheet.addAction(blueAction)
        actionsheet.addAction(yellowAction)
        actionsheet.addAction(greenAction)
        actionsheet.addAction(cancelAction)
        
        self.presentViewController(actionsheet, animated: true, completion: nil)
    }
    
    func updateColorTextField() {
        self.colorButton.setTitle((mainVC.getSetting("guideColor") as! UIColor).description, forState: .Normal)
    }
    
    
    @IBAction func disableBackgroundBlur(sender: AnyObject) {
        self.mainVC.setSetting("backgroundBlur", setting: sender.on)
    }
    
    @IBAction func confirmScanInfo(sender: AnyObject) {
         self.mainVC.setSetting("scanConfirmation", setting: sender.on)
    }
    
    @IBAction func confirmWithManualEntry(sender: AnyObject) {
         self.mainVC.setSetting("suppressScannedCardImage", setting: sender.on)
    }
    
    @IBAction func hideCardIOLabel(sender: AnyObject) {
         self.mainVC.setSetting("hideCardIOLogo", setting: sender.on)
    }
    
    @IBAction func disableManualEntryButtons(sender: AnyObject) {
         self.mainVC.setSetting("disableManualEntryButtons", setting: sender.on)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.tag == 0 {
            //locale
            self.mainVC.setSetting("locale", setting: textField.text!)
        } else if textField.tag == 1 {
            //duration
            let num =  NSNumberFormatter().numberFromString(textField.text!)
            self.mainVC.setSetting("scannedImageDuration", setting: num!)
        }
        return true
    }
    
    @IBAction func updateManualEntryOnly(sender: AnyObject) {
        self.mainVC.setSetting("manualEntry", setting: sender.on)
    }
    @IBAction func collectCVV(sender: AnyObject) {
        self.mainVC.setSetting("collectCVV", setting: sender.on)
    }
    @IBAction func collectName(sender: AnyObject) {
        self.mainVC.setSetting("collectName", setting: sender.on)
    }
    @IBAction func dismissKeyBoardGesture(sender: AnyObject) {
        print("tap recognized")
        self.localeTextField.resignFirstResponder()
        self.scannedImageDurationTextField.resignFirstResponder()
    }
}
