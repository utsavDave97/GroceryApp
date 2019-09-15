//
//  OnboardingViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-13.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController
{
    //MARK: Outlets
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var nextButton: UIButton! {
        didSet
        {
            nextButton.layer.cornerRadius = 10
            nextButton.layer.masksToBounds = true
        }
    }
    
    //MARK: Properties
    var onboardingPageViewController: OnboardingPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    /**
     When the next button is clicked check the index first.
     Depending on the index use switch-case statement to go forward or to finish onboarding.
     **/
    
    @IBAction func nextButtonTapped(sender: UIButton)
    {
        if let index = onboardingPageViewController?.currentIndex {
            switch index
            {
            case 0...1:
                onboardingPageViewController?.forwardPage()
            case 2:
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
        
        //Update UI as per the page on Screen
        updateUI()
    }
    
    //MARK: View Controller Life cycle
    /**
     This function updates the title of next button based on index.
     Also, it changes the page control index.
     **/
    func updateUI()
    {
        if let index = onboardingPageViewController?.currentIndex
        {
            switch index
            {
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
            case 2:
                nextButton.setTitle("GET STARTED", for: .normal)
            default:
                break
            }
            
            pageControl.currentPage = index
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destination = segue.destination
        if let pageViewController = destination as? OnboardingPageViewController
        {
            onboardingPageViewController = pageViewController
            onboardingPageViewController?.onboardingPageViewControllerDelegate = self
        }
    }

}

extension OnboardingViewController: OnboardingPageViewControllerDelegate
{
    func didUpdatePageIndex(currentIndex: Int)
    {
        updateUI()
    }
}
