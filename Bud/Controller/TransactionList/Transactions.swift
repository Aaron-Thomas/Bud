//
//  ViewController.swift
//  Bud
//
//  Created by Aaron Thomas on 07/05/2019.
//  Copyright © 2019 InteractiveCode. All rights reserved.
//

import UIKit

class Transactions: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeBtn: UIButton!
    
    var transactions = [TransactionData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        setupEditButtonUI()
        
        showLoadingView()
        getTransactions { result in
            switch result {
            case .success(let transactionObj):
                guard let transactionData = transactionObj.data else { return }
                self.transactions = transactionData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showErrorPopoverView(errorTitle: "Something Went Wrong", errorMessage: error.localizedDescription)
                }
            }
            self.hideLoadingView()
        }
    }
    
    func setupEditButtonUI() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        let barbuttonFont = UIFont.systemFont(ofSize: 12)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: barbuttonFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    func getTransactions(completion: @escaping (Result<Transaction, Error>) -> ()) {
        let urlString = "http://www.mocky.io/v2/5b36325b340000f60cf88903"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let downloadError = error {
                completion(.failure(downloadError))
                return
            }
            
            do {
                let transactionObj = try JSONDecoder().decode(Transaction.self, from: data!)
                completion(.success(transactionObj))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    @IBAction func removeBtnPrsd() {
        removeSelectedValues()
    }
    
    func removeSelectedValues() {
        if let selectedIndexes = tableView.indexPathsForSelectedRows {
            
            let sortedSelectedIndexes = selectedIndexes.sorted()
            
            sortedSelectedIndexes.reversed().forEach { i in
                transactions.remove(at: i.row)
            }
            
            DispatchQueue.main.async {
                self.removeBtn.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
}

