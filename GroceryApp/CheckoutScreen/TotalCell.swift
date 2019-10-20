//
//  TotalCell.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-19.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import Foundation
import UIKit

class TotalCell: UITableViewCell
{
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with total: Double)
    {
        totalAmountLabel.text = String(format: "Total: $%.2f", total)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
