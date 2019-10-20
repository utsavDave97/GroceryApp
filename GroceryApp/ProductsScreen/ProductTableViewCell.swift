//
//  ProductTableViewCell.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-18.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell
{
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.productImage.layer.cornerRadius = 8.0
        self.productImage.layer.masksToBounds = true
        self.productImage.layer.shadowColor = UIColor.black.cgColor
        self.productImage.layer.shadowOffset = CGSize(width: 5.0, height: 5.0);
        self.productImage.layer.shadowRadius = 6;
        self.productImage.layer.shadowOpacity = 0.5;
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
}
