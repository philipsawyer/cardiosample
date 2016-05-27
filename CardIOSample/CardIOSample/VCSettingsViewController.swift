//
//  VCSettingsViewController.swift
//  CardIOSample
//
//  Created by Philip Sawyer on 5/27/16.
//  Copyright © 2016 Philip Sawyer. All rights reserved.
//

import UIKit

class VCSettingsViewController: UIViewController {
    
    var settingsHelper: VCSettingsHelper!

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
        
        settingsHelper = VCSettingsHelper()
        
        self.localeTextField.text = self.settingsHelper.getSetting("locale") as? String
        self.backgroundBlurSwitch.on = self.settingsHelper.getSetting("backgroundBlur") as! Bool
        self.colorButton.titleLabel?.text = (self.settingsHelper.getSetting("guideColor") as! UIColor).description
        self.confirmScanInfoSwitch.on = self.settingsHelper.getSetting("scanConfirmation") as! Bool
        //cardIOVC.suppressScannedCardImage = self.settingsHelper.getSetting("suppressScannedCardImage") as! Bool
        self.scannedImageDurationTextField.text = "\((self.settingsHelper.getSetting("scannedImageDuration") as! CGFloat))"
        self.hideCardIOLabel.on = self.settingsHelper.getSetting("hideCardIOLogo") as! Bool
        self.disableManualEntryButtonsSwitch.on = self.settingsHelper.getSetting("disableManualEntryButtons") as! Bool
    }
    
    
    @IBAction func changeColorGuide(sender: AnyObject) {
    }
}
