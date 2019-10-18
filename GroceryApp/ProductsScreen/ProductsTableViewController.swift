//
//  ProductsTableViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-18.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import Hero

class ProductsTableViewController: UITableViewController
{
    var categoryId: Int?
    
    static let api = API()
    
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero.isEnabled = true
        
        ProductsTableViewController.api.getProducts(categoryId: categoryId!) { (products) in
            self.products = products
            
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell

        // Configure the cell...
        cell.productName.text = products[indexPath.row].name
        cell.productPrice.text = String(format: "%.2f", products[indexPath.row].price)
        
        cell.productImage.hero.id = "productImage"
        
        let url = URL(string: products[indexPath.row].imageURL)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            cell.productImage.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
