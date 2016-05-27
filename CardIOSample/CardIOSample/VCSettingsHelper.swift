//
//  VCSettingsHelper.swift
//  CardIOSample
//
//  Created by Philip Sawyer on 5/27/16.
//  Copyright © 2016 Philip Sawyer. All rights reserved.
//

import UIKit

class VCSettingsHelper: NSObject {
    var settingsDict : [String : AnyObject]!
    
    override init() {
        super.init()
        let defaultColor = UIColor.greenColor()
        
        settingsDict = ["locale" : "en", "backgroundBlur" : false, "guideColor" : defaultColor, "scanConfirmation" : false, "suppressScannedCardImage" : false, "scannedImageDuration" : 0.1, "hideCardIOLogo" : false, "disableManualEntryButtons" : false]
    }
    
    func getSetting(key : String) -> AnyObject {
        return settingsDict[key]!
    }
    
    func setSetting(key : String, setting : AnyObject) {
        self.settingsDict[key] = setting
    }
}
