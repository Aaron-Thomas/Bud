//
//  Transaction.swift
//  Bud
//
//  Created by Aaron Thomas on 07/05/2019.
//  Copyright © 2019 InteractiveCode. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    
    var data: [TransactionData]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try container.decodeIfPresent([TransactionData].self, forKey: .data) ?? nil
    }
}

struct TransactionData: Codable {
    
    var id: String
    var date: String
    var description: String
    var category: String
    var currency: String
    var amount: Amount?
    var product: Product?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        category = try container.decodeIfPresent(String.self, forKey: .category) ?? ""
        currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
        amount = try container.decodeIfPresent(Amount.self, forKey: .amount) ?? nil
        product = try container.decodeIfPresent(Product.self, forKey: .product) ?? nil
    }
}

struct Amount: Codable {
    
    var value: Double
    var currency_iso: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        value = try container.decodeIfPresent(Double.self, forKey: .value) ?? 0.0
        currency_iso = try container.decodeIfPresent(String.self, forKey: .currency_iso) ?? ""
    }
}

struct Product: Codable {
    
    var id: Int
    var title: String
    var icon: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        icon = try container.decodeIfPresent(String.self, forKey: .icon) ?? ""
    }
}
