//
//  Transactions+TableViewDelegate.swift
//  Bud
//
//  Created by Aaron Thomas on 07/05/2019.
//  Copyright © 2019 InteractiveCode. All rights reserved.
//

import UIKit

extension Transactions: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactioncell", for: indexPath) as? TransactionCell else { return UITableViewCell() }
        
        let transaction = transactions[indexPath.row]
        cell.configureCell(transactionData: transaction)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isEditing
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateRemoveBtnUI()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateRemoveBtnUI()
    }
    
    func updateRemoveBtnUI() {
        if let _ = tableView.indexPathsForSelectedRows {
            DispatchQueue.main.async {
                self.removeBtn.isHidden = false
            }
        } else {
            DispatchQueue.main.async {
                self.removeBtn.isHidden = true
            }
        }
    }
    
    override func setEditing (_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        if self.isEditing {
            tableView.allowsMultipleSelection = true
            tableView.allowsMultipleSelectionDuringEditing = true
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.editButtonItem.title = "Done"
            }
        } else {
            tableView.allowsMultipleSelection = false
            tableView.allowsMultipleSelectionDuringEditing = false
            removeBtn.isHidden = true
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.editButtonItem.title = "Edit"
            }
        }
    }
}
