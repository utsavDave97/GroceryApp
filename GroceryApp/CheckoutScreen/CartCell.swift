//
//  CartCell.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-19.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell
{
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.productImage.layer.cornerRadius = 8.0
        self.productImage.layer.masksToBounds = true
        self.productImage.layer.shadowColor = UIColor.black.cgColor
        self.productImage.layer.shadowOffset = CGSize(width: 5.0, height: 5.0);
        self.productImage.layer.shadowRadius = 6;
        self.productImage.layer.shadowOpacity = 0.5;
    }
    
    func configure(with product: Product)
    {
        productName.text = product.name
        totalPriceLabel.text = "$\(product.price)"
        
        let url = URL(string: product.imageURL)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            productImage.image = UIImage(data: imageData)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
