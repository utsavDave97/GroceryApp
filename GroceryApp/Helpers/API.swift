//
//  API.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-13.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import Foundation
import Alamofire

class API
{
    func getCategories(completed:@escaping (_ categories: [Category])-> Void)
    {
        guard let url = URL(string: "https://php.scweb.ca/~udave/GroceryLaravel/api/categories")
            else {return}
        
        AF.request(url,method: .get).responseJSON
        {  (response) in
            
            guard response.error == nil
            else
            {
                print(response.error?.errorDescription ?? "Error")
             return
            }
            
            switch response.result
            {
            case .success(_):
                guard let data = response.data else {return}
                 do
                 {
                    let myResponse = try JSONDecoder().decode([Category].self, from: data)
                    
                     completed(myResponse)
                 }
                catch{}
                break
            case .failure(let error):
                print("Error getting response \(error)")
            }
        }
    }
    
    func getProducts(categoryId: Int,completed:@escaping (_ products: [Product])-> Void)
    {
        guard let url = URL(string: "https://php.scweb.ca/~udave/GroceryLaravel/api/categories/\(categoryId)/products")
            else {return}
        
        AF.request(url,method: .get).responseJSON
        {  (response) in
            
            guard response.error == nil
            else
            {
                print(response.error?.errorDescription ?? "Error")
             return
            }
            
            switch response.result
            {
            case .success(_):
                guard let data = response.data else {return}
                 do
                 {
                    let myResponse = try JSONDecoder().decode([Product].self, from: data)
                    
                     completed(myResponse)
                 }
                catch{}
                break
            case .failure(let error):
                print("Error getting response \(error)")
            }
        }
    }
}
