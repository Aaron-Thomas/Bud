//
//  NumberFormatter.swift
//  Bud
//
//  Created by Aaron Thomas on 15/05/2019.
//  Copyright © 2019 InteractiveCode. All rights reserved.
//

import Foundation

class CurrencyFormatter {
    
    static let shared = CurrencyFormatter()

    let formatter = NumberFormatter()
    
    func formatValueFromCurrencyIso(value: Double, currencyIso: String) -> String {
        formatter.numberStyle = NumberFormatter.Style.currencyAccounting
        formatter.locale = Locale.current
        formatter.currencyCode = currencyIso
        
        guard let formattedString = formatter.string(from: NSNumber(value: value)) else { return "" }
        return formattedString
    }
}
