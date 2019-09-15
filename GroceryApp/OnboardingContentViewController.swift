//
//  OnboardingContentViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-13.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class OnboardingContentViewController: UIViewController
{
    // MARK: Outlets
    @IBOutlet var headingLabel: UILabel! {
        didSet
        {
            headingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var subHeadingLabel: UILabel! {
        didSet
        {
            subHeadingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var contentImageView: UIImageView!
    
    // MARK: Variables
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
    }
}
