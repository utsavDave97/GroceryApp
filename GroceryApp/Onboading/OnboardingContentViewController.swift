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

        //Set the text of labels
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        
        //Set the image of UIImage with image inside assets
        contentImageView.image = UIImage(named: imageFile)
    }
}
