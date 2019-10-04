//
//  ProfileViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-30.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController
{
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Create settings button with the image
        let settingsButton = UIBarButtonItem(image: UIImage(named:"settings.png"), style: .plain, target: self, action: #selector(settingsPressed))
        
        //Set the tint color of settings button
        settingsButton.tintColor = UIColor.black
        
        //Set the rightbar button of navigation item to be settings
        self.navigationItem.rightBarButtonItem = settingsButton
        navBar.setItems([navigationItem], animated: false)
        
        setUpButton()
       
    }
    
    @IBAction func cartButtonTapped(_ sender: Any) {
    }
    
    private func setUpButton()
    {
        cartButton.layer.shadowColor = UIColor(red: 0.99, green: 0.03, blue: 0.30, alpha: 1.0).cgColor
       cartButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
       cartButton.layer.shadowOpacity = 1.0
       cartButton.layer.shadowRadius = 5
       cartButton.layer.masksToBounds = false
    }
    
    @objc private func settingsPressed()
    {
        
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
