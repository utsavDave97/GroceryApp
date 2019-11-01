//
//  StripeClient.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-25.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

enum Result {
  case success
  case failure(Error)
}

final class StripeClient {
  
  static let shared = StripeClient()
  
  private init() {
    // private
  }
  
  private lazy var baseURL: URL = {
    guard let url = URL(string: Constants.baseURLString) else {
      fatalError("Invalid URL")
    }
    return url
  }()
  
  func completeCharge(with token: String, amount: Int, completion: @escaping (Result) -> Void) {
    /*
     First, append the charge method path to the baseURL, in order to invoke the charge API available in your back end. You will implement this API shortly.
     */
    let url = baseURL
    
    
    /*
     Next, build a dictionary containing the parameters needed for the charge API. token, amount and currency are mandatory fields.
     */
    let params: [String: Any] = [
      "amount": amount,
      "description": Constants.defaultDescription
    ]
    
    /*
     Finally, make a network request using Alamofire to perform the charge. When the request completes, it invokes a completion closure with the result of the request.
     */
    AF.request(url, method: .post, parameters: params)
      .validate(statusCode: 200..<300)
      .responseString { response in
        switch response.result
        {
        case .success:
            print("SUCESSSSSS: \(Result.success)")
          completion(Result.success)
            break
        case .failure(let error):
          completion(Result.failure(error))
        }
    }
  }
}
