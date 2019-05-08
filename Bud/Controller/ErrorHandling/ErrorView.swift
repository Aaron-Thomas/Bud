//
//  ErrorView.swift
//  Bud
//
//  Created by Aaron Thomas on 07/05/2019.
//  Copyright © 2019 InteractiveCode. All rights reserved.
//

import UIKit

class ErrorView: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    var errorTitle: String!
    var errorMessage: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        self.titleLbl.text = errorTitle
        self.messageTextView.text = errorMessage
    }
    
    @IBAction func okayBtnPrsd() {
        self.dismiss(animated: true, completion: nil)
    }
}
