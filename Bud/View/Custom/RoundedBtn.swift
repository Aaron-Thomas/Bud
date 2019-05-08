//
//  RoundedBtn.swift
//  Bud
//
//  Created by Aaron Thomas on 07/05/2019.
//  Copyright © 2019 InteractiveCode. All rights reserved.
//

import UIKit

class RoundedBtn: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 25
    }
}
