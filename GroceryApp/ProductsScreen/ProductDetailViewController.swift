//
//  ProductDetailViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-18.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController
{
    //MARK: Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productInfo: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    {
        didSet
        {
            addToCartButton.layer.cornerRadius = 7
            addToCartButton.layer.masksToBounds = true
            addToCartButton.layer.shadowColor = UIColor.black.cgColor
            addToCartButton.layer.shadowOffset = CGSize(width: 5.0, height: 5.0);
            addToCartButton.layer.shadowRadius = 6;
            addToCartButton.layer.shadowOpacity = 0.5;
        }
    }
    
    var product: Product?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func setUpUI()
    {
        productName.text = product!.name
        productPrice.text = String(format: "$%.2f", product!.price)
        productInfo.text = product!.info
        
        let url = URL(string: product!.imageURL)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            productImage.image = UIImage(data: imageData)
        }
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any)
    {
        CheckoutCart.shared.addProduct(product!)
    }
    
}
