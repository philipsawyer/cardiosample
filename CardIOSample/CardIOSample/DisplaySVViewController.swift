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
    @IBOutlet weak var cancelButton: UIButton!
    
    var cardIOView : CardIOView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CardIO as SubView"
        
        if !CardIOUtilities.canReadCardWithCamera() {
            self.scanCardButton.hidden = true
            self.resultsLabel.text = "Camera is not supported"
        } else {
            self.resultsLabel.hidden = true
        }
        self.cancelButton.hidden = true
        
        let rect = CGRect(x: 10, y: 10, width: 400, height: 400)
        self.cardIOView = CardIOView(frame: rect)
        cardIOView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        CardIOUtilities.preload()
    }
    
    func cardIOView(cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        print("didScanCard")
        
        if cardInfo != nil {
            let result = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", cardInfo.redactedCardNumber, cardInfo.expiryMonth, cardInfo.expiryYear, cardInfo.cvv)
            self.resultsLabel.hidden = false
            self.resultsLabel.text = result as String
        } else {
            self.resultsLabel.hidden = false
            self.resultsLabel.text = "Error occured in scanning card"
        }
        
        cardIOView.removeFromSuperview()
    }
    
    @IBAction func scanCard(sender: AnyObject) {
        self.view.addSubview(cardIOView)
        self.cancelButton.hidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeCardView()
    }
    @IBAction func cancelScan(sender: AnyObject) {
        self.removeCardView()
        self.cancelButton.hidden = true
    }
    
    func removeCardView() {
        self.cardIOView.removeFromSuperview()
    }
}
