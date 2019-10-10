//
//  ViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-10.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        // Do any additional setup after loading the view.
    }

    
    /**
     This function would first make sure if the user has already seen the onboarding or not.
     Based on the userDefaults the user would be represented with onboarding.
     **/
    override func viewDidAppear(_ animated: Bool)
    {
        
    }

}


extension HomeViewController: UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView =  selectedViewController?.view, let toView = viewController.view
            else {return false}
        
        if fromView != toView
        {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
