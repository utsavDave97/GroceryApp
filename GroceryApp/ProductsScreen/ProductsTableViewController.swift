//
//  ProductsTableViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-18.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController
{
    var categoryId: Int?
    
    static let api = API()
    
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    var products = [Product]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
        
        activityIndicator.startAnimating()
        
        ProductsTableViewController.api.getProducts(categoryId: categoryId!) { (products) in
            self.products = products
            
            self.activityIndicator.stopAnimating()
            
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
        cell.productPrice.text = String(format: "$%.2f", products[indexPath.row].price)
        
        //cell.addProductTapped(products[indexPath.row])
        
        let url = URL(string: products[indexPath.row].imageURL)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            cell.productImage.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let detailVC = segue.destination as! ProductDetailViewController
        if let cell = sender as? ProductTableViewCell,
            let indexPath = self.tableView.indexPath(for: cell)
        {
            let product = products[indexPath.row]
            detailVC.product = product
        }
    }
}
