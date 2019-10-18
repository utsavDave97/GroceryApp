//
//  Product.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-01.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int
    let name: String
    let price: Double
    let info: String
    let imageURL: String
    let categoryID: Int

    enum CodingKeys: String, CodingKey {
        case id, name, price, info, imageURL
        case categoryID = "category_id"
    }
}
