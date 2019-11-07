//
//  OnboardingPageViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-13.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

protocol OnboardingPageViewControllerDelegate: class
{
    func didUpdatePageIndex(currentIndex: Int)
}

class OnboardingPageViewController: UIPageViewController
{
    //MARK: Properties
    var pageHeadings = ["Need Groceries Now?","Hassle Free Payments","Doorstep Deliveries"]
    var pageImages = ["onboard1","onboard2","onboard3"]
    var pageSubHeadings = ["Select wide range of products from fresh fruits to delicious snacks","Pay as per your convenience, we accept all credit and debit cards","Our delivery will be delivered within 24 hours"]
    
    //Declare the current index
    var currentIndex = 0
    weak var onboardingPageViewControllerDelegate: OnboardingPageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        // Create the first onboarding screen
        if let startingViewController = contentViewController(at: 0)
        {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
}

//MARK: PageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDataSource
{
    /**
     This UIPageViewControllerDataSource method presents the view controller before the index
     **/
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    /**
     This UIPageViewControllerDataSource method presents the view controller after the index
     **/
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    /**
     This function gets the data based on the index number passed to its parameter
     **/
    func contentViewController(at index: Int) -> OnboardingContentViewController?
    {
        //Check if the index number passed is not less than 0 and more than the number of screens
        if index < 0 || index >= pageHeadings.count
        {
            return nil
        }
        
        //Get the storyboard by its name
        let storyBoard = UIStoryboard(name: "OnBoarding", bundle: nil)
        //Instantiate the view controller by its identifier and pass the appropriate data
        if let onboardingContentViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingContentViewController") as? OnboardingContentViewController {
            onboardingContentViewController.imageFile = pageImages[index]
            onboardingContentViewController.heading = pageHeadings[index]
            onboardingContentViewController.subHeading = pageSubHeadings[index]
            onboardingContentViewController.index = index
            return onboardingContentViewController
        }
        
        return nil
    }
    
    /**
     This function forwards the view controller when the next button is tapped
     **/
    func forwardPage()
    {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex)
        {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

//MARK: PageViewControllerDelegate
extension OnboardingPageViewController: UIPageViewControllerDelegate
{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if completed
        {
            if let contentViewController = pageViewController.viewControllers?.first as? OnboardingContentViewController
            {
                currentIndex = contentViewController.index
 onboardingPageViewControllerDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
}
