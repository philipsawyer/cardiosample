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
        
        title = "Settings"
        
        localeTextField.text = mainVC.config.locale
        backgroundBlurSwitch.on = mainVC.config.backgroundBlur
        colorButton.setTitle(mainVC.config.guideColor.description, forState: .Normal)
        confirmScanInfoSwitch.on = mainVC.config.scanConfirmation
        confirmWithManualSwitch.on = mainVC.config.suppressScannedCardImage
        scannedImageDurationTextField.text = "\((mainVC.config.scannedImageDuration))"
        hideCardIOLabel.on = mainVC.config.hideCardIOLogo
        disableManualEntryButtonsSwitch.on = mainVC.config.disableManualEntryButtons
        manualOnlySwitch.on = mainVC.config.manualEntry
        collectCVVSwitch.on = mainVC.config.collectCVV
        collectNameSwtich.on = mainVC.config.collectName
    }
    
    
    @IBAction func changeColorGuide(sender: AnyObject) {
        let actionsheet = UIAlertController(title: "Select Color", message: nil, preferredStyle: .ActionSheet)
        let orangeAction = UIAlertAction(title: "Orange", style: .Default) { action -> Void in
            self.setColor(UIColor.orangeColor())
        }
        let redAction = UIAlertAction(title: "Red", style: .Default) { action -> Void in
            self.setColor(UIColor.redColor())
        }
        let blueAction = UIAlertAction(title: "Blue", style: .Default) { action -> Void in
            self.setColor(UIColor.blueColor())
        }
        let yellowAction = UIAlertAction(title: "Yellow", style: .Default) { action -> Void in
            self.setColor(UIColor.yellowColor())
        }
        let greenAction = UIAlertAction(title: "Green", style: .Default) { action -> Void in
            self.setColor(UIColor.greenColor())
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionsheet.addAction(orangeAction)
        actionsheet.addAction(redAction)
        actionsheet.addAction(blueAction)
        actionsheet.addAction(yellowAction)
        actionsheet.addAction(greenAction)
        actionsheet.addAction(cancelAction)
        
        presentViewController(actionsheet, animated: true, completion: nil)
    }
    
    func setColor(color : UIColor) {
        mainVC.config.guideColor = color
        updateColorTextField()
    }
    
    func updateColorTextField() {
        colorButton.setTitle(mainVC.config.guideColor.description, forState: .Normal)
    }
    
    
    @IBAction func disableBackgroundBlur(sender: AnyObject) {
        mainVC.config.backgroundBlur = sender.on
    }
    
    @IBAction func confirmScanInfo(sender: AnyObject) {
         mainVC.config.scanConfirmation = sender.on
    }
    
    @IBAction func confirmWithManualEntry(sender: AnyObject) {
         mainVC.config.suppressScannedCardImage = sender.on
    }
    
    @IBAction func hideCardIOLabel(sender: AnyObject) {
         mainVC.config.hideCardIOLogo = sender.on
    }
    
    @IBAction func disableManualEntryButtons(sender: AnyObject) {
         mainVC.config.disableManualEntryButtons = sender.on
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == localeTextField {
            //locale
            mainVC.config.locale = textField.text!
        } else if textField == scannedImageDurationTextField {
            //duration
            let num =  NSNumberFormatter().numberFromString(textField.text!)
            mainVC.config.scannedImageDuration = num as! CGFloat
        }
        return true
    }
    
    @IBAction func updateManualEntryOnly(sender: AnyObject) {
        mainVC.config.manualEntry = sender.on
    }
    @IBAction func collectCVV(sender: AnyObject) {
        mainVC.config.collectCVV = sender.on
    }
    @IBAction func collectName(sender: AnyObject) {
        mainVC.config.collectName = sender.on
    }
    @IBAction func dismissKeyBoardGesture(sender: AnyObject) {
        print("tap recognized")
        localeTextField.resignFirstResponder()
        scannedImageDurationTextField.resignFirstResponder()
    }
}
