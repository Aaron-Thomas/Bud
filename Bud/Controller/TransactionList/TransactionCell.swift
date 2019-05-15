//
//  TransactionsCell.swift
//  Bud
//
//  Created by Aaron Thomas on 07/05/2019.
//  Copyright © 2019 InteractiveCode. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(transactionData: TransactionData) {
        descriptionLbl.text = transactionData.description
        categoryLbl.text = transactionData.category
    
        if let iconUrl = transactionData.product?.icon {
             iconImageView.loadImageUsingCacheWithUrlString(iconUrl)
        }
        
        guard let value = transactionData.amount?.value, let currencyIso = transactionData.amount?.currency_iso else { return }
        amountLbl.text = CurrencyFormatter.shared.formatValueFromCurrencyIso(value: value, currencyIso: currencyIso)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            let bgView = UIView()
            bgView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                
            DispatchQueue.main.async {
                self.selectedBackgroundView = bgView
                self.bringSubviewToFront(bgView)
            }
        }
    }
}
