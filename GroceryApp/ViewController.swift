//
//  ViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-10.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    /**
     This function would first make sure if the user has already seen the onboarding or not.
     Based on the userDefaults the user would be represented with onboarding.
     **/
    override func viewDidAppear(_ animated: Bool)
    {
        if UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        {
            return
        }
        
        let storyBoard = UIStoryboard(name: "OnBoarding", bundle: nil)
        if let onboardingViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController {
            present(onboardingViewController, animated: true, completion: nil)
        }
    }

}

