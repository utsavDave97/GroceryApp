//
//  LoginViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-15.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController
{
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the UI
        setUpForm()
        
        //Also check if ther user is logged in or not
        checkIfUserLoggedIn()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        //Check if the user has seen onboarding screens with the help of boolean value stored inside UserDefaults
        if UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        {
            return
        }
        
        let storyBoard = UIStoryboard(name: "OnBoarding", bundle: nil)
        if let onboardingViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController {
            onboardingViewController.modalPresentationStyle = .fullScreen
            present(onboardingViewController, animated: true, completion: nil)
        }
    }
    
    func setUpForm()
    {
        //Hide the error label
        errorLabel.alpha = 0
    }
    

    @IBAction func loginButtonTapped(_ sender: Any)
    {
        //Validate the text fields
        let error = validateFields()
        
        if error != nil
        {
            //There's something wrong with the fields, show error message
            showError(error)
        }
        else
        {
            //Create cleaned versions of the text fields
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Signing in the users
            Auth.auth().signIn(withEmail: email, password: password)
            { (result, err) in
               
                //Check for errors
               if err != nil
               {
                //There was an error creating the user
                self.showError(err?.localizedDescription)
               }
                else
                {
                //Store the email and password inside UserDefaults
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(password, forKey: "password")
                    
                //Transition to home screen
                self.transitionToHome()
                } 
            }
        }
    }
    
    func validateFields() -> String?
    {
        //Check all the fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        return nil
    }
    
    //This function makes the errorLabel's visibility on or off
    fileprivate func showError(_ error: String?)
    {
        errorLabel.text = error!
        errorLabel.alpha = 1
    }
        
    /*
     This function would be called after the user has successfully typed in credentials and would be redirected to homeScreen of the app
     */
    func transitionToHome()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController {
            homeViewController.modalPresentationStyle = .fullScreen
            present(homeViewController, animated: true, completion: nil)
        }
    }
    
    //Check if user is logged in or not
    private func checkIfUserLoggedIn()
    {
        //If the user is logged in than take the user to home screen directly
        if Auth.auth().currentUser != nil
        {
            transitionToHome()
        }
        // Else stay on log in screen
        else
        {
            return
        }
    }
}
