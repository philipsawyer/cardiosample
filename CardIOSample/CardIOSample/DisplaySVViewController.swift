//
//  DisplaySVViewController.swift
//  CardIOSample
//
//  Created by Philip Sawyer on 5/26/16.
//  Copyright © 2016 Philip Sawyer. All rights reserved.
//

import UIKit

class DisplaySVViewController: UIViewController, CardIOViewDelegate {
    
    @IBOutlet weak var scanCardButton: UIButton!
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !CardIOUtilities.canReadCardWithCamera() {
            self.scanCardButton.hidden = true
            self.resultsLabel.text = "Camera is not supported"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        CardIOUtilities.preload()
    }
    
    func cardIOView(cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        print("didScanCard")
        
        if cardInfo != nil {
            let result = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", cardInfo.redactedCardNumber, cardInfo.expiryMonth, cardInfo.expiryYear, cardInfo.cvv)
            self.resultsLabel.text = result as String
        } else {
            self.resultsLabel.text = "Error occured in scanning card"
        }
        
        cardIOView.removeFromSuperview()
    }
    
    @IBAction func scanCard(sender: AnyObject) {
        let rect = CGRect(x: 10, y: 10, width: 200, height: 200)
        let cardIOView = CardIOView(frame: rect)
        cardIOView.delegate = self
        
        self.view.addSubview(cardIOView)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        for view in self.view.subviews {
            if view.isKindOfClass(CardIOView) {
                view.removeFromSuperview()
            }
        }
    }
}
