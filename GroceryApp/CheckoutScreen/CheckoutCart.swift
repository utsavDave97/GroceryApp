//
//  File.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-19.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import Foundation

final class CheckoutCart {

  static let shared = CheckoutCart()
  
  private init() {
    // private
  }

  private var products: [Product] = []

  var cart: [Product] {
    return products
  }
  
  var canPay: Bool {
    return !products.isEmpty
  }

  var total: Double {
     return products.reduce(0, { result, product -> Double in
         return result + product.price
       })
  }

  func addProduct(_ product: Product) {
    guard !products.contains(product) else {
      return
    }
    products.append(product)
  }
  
  func removeProduct(_ product: Product) -> Bool {
    guard let index = products.firstIndex(of: product) else {
      return false
    }
    products.remove(at: index)
    return true
  }

}
