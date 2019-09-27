//
//  ForgotPasswordViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-15.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController
{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    func setUpForm()
    {
        //Hide the error label
        errorLabel.alpha = 0
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpForm()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendEmailButtonTapped(_ sender: Any)
    {
        //Validate fields
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
            
            Auth.auth().sendPasswordReset(withEmail: email)
            { (error) in
                
                //Check for errors
                if error != nil
                {
                    //There was an error sending the mail
                 self.showError(error?.localizedDescription)
                }
                else
                {
                    //Transition to login screen
                    self.transitionToLogin()
                }
            }
        }
    }
    
    func validateFields() -> String?
    {
        //Check all the fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        return nil
    }
    
    fileprivate func showError(_ error: String?)
    {
        
        errorLabel.text = error!
        errorLabel.alpha = 1
    }
    
    func transitionToLogin()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController {
            present(homeViewController, animated: true, completion: nil)
        }
    }
    
}
