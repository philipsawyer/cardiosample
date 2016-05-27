//
//  VCSettingsViewController.swift
//  CardIOSample
//
//  Created by Philip Sawyer on 5/27/16.
//  Copyright © 2016 Philip Sawyer. All rights reserved.
//

import UIKit

class VCSettingsViewController: UIViewController {
    
    var mainVC : DisplayVCViewController!

    @IBOutlet weak var localeTextField: UITextField!
    @IBOutlet weak var backgroundBlurSwitch: UISwitch!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var confirmScanInfoSwitch: UISwitch!
    @IBOutlet weak var confirmWithManualSwitch: UISwitch!
    @IBOutlet weak var scannedImageDurationTextField: UITextField!
    
    @IBOutlet weak var hideCardIOLabel: UISwitch!
    @IBOutlet weak var disableManualEntryButtonsSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.localeTextField.text = mainVC.getSetting("locale") as? String
        self.backgroundBlurSwitch.on = mainVC.getSetting("backgroundBlur") as! Bool
        self.colorButton.setTitle((mainVC.getSetting("guideColor") as! UIColor).description, forState: .Normal)
        self.confirmScanInfoSwitch.on = mainVC.getSetting("scanConfirmation") as! Bool
        //cardIOVC.suppressScannedCardImage = mainVC.getSetting("suppressScannedCardImage") as! Bool
        self.scannedImageDurationTextField.text = "\((mainVC.getSetting("scannedImageDuration") as! CGFloat))"
        self.hideCardIOLabel.on = mainVC.getSetting("hideCardIOLogo") as! Bool
        self.disableManualEntryButtonsSwitch.on = mainVC.getSetting("disableManualEntryButtons") as! Bool
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
    
}
