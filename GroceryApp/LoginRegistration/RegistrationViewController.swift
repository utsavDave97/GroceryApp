//
//  RegistrationViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-15.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegistrationViewController: UIViewController
{
    //MARK: Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var backToLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpForm()
    }
    
    func setUpForm()
    {
        //Hide the error label
        errorLabel.alpha = 0
    }
    
    /*
     Check the fields and validate the data is correct
     If everything is correct, this method returns nil. Otherwise, it returns the error message
     */
    func validateFields() -> String?
    {
        //Check all the fields are filled in
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        //Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false
        {
            //Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        
        return nil
    }
    
    //MARK: Actions
    @IBAction func signUpTapped(_ sender: Any)
    {
        //Validate the fields
        let error = validateFields()
        
        if error != nil
        {
            //There's something wrong with the fields, show error message
            showError(error)
        }
        else
        {
            //Create cleaned versions of the data
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password)
            { (result, err) in
                
                //Check for errors
                if err != nil {
                    //There was an error creating the user
                    self.showError("Error creating user")
                }
                else
                {
                    //User was created successfully, store the details
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: [
                        "fname" : name,
                        "uid" : result!.user.uid ])
                    { (error) in
                        
                        if error != nil
                        {
                            self.showError("Error saving user data")
                        }
                    }
                    
                    //Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    fileprivate func showError(_ error: String?)
    {
        
        errorLabel.text = error!
        errorLabel.alpha = 1
    }
    
    func transitionToHome()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController {
            homeViewController.modalPresentationStyle = .fullScreen
            present(homeViewController, animated: true, completion: nil)
        }
        
//        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
//
//        view.window?.rootViewController = homeViewController
//        view.window?.makeKeyAndVisible()
        
    }
    
}

