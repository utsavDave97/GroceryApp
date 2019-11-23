//
//  UpdateEmailViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-21.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UpdateEmailViewController: UIViewController
{
    //MARK: Properties
    var userEmail: String = ""
    var userPassword: String = ""
    
    //MARK: Outlets
    @IBOutlet weak var updateEmailButton: UIButton!
    {
        didSet
        {
            updateEmailButton.layer.cornerRadius = 7
            updateEmailButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var currentEmailTextField: UITextField!
    
    /*
     Inside viewDidLoad get the email and password from UserDefaults
     and set the text of email text field to that value received for that key.
     We don't want user to edit the current email text field so we set the boolean value of isEnabled to false.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
        userEmail = UserDefaults.standard.string(forKey: "email")!
        userPassword = UserDefaults.standard.string(forKey: "password")!
        
        currentEmailTextField.text = userEmail
        currentEmailTextField.isEnabled = false
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @IBAction func updateEmailButtonTapped(_ sender: Any)
    {
        /*
         create a credential with the help of values got from UserDefaults for email and password.
        */
        let credential = EmailAuthProvider.credential(withEmail: self.userEmail, password: self.userPassword)
     
        /*
         Check if there is string inside new email text field and check if it is empty or not.
        */
        if let newEmail = newEmailTextField.text, !newEmail.isEmpty
        {
            /*
             Get the current user with the help of Firebase's Auth object
            */
            if let currentUser = Auth.auth().currentUser
            {
                /*
                 In order to update user's email, we first need to reauthenticate user as this kind of actions require user's consent.
                */
                currentUser.reauthenticate(with: credential) { (result, error) in
                    if let error = error
                    {
                        print(error)
                    }
                    else
                    {
                        /*
                         Use the updateEmail method of Firebase to update email, which takes in new email and a completion handler
                        */
                        currentUser.updateEmail(to: newEmail, completion: { (error) in
                            //If there are any errors, print the cause of error
                            if let error = error
                            {
                                print(error)
                            }
                            else
                            {
                                //If the operation was a success than, take the user back to log in screen and make him log in again with new email
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                if let loginVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController {
                                    loginVC.modalPresentationStyle = .fullScreen
                                    self.present(loginVC, animated: true, completion: nil)
                                }
                            }
                        })
                    }
                }
            }
        }
        else
        {
            /*
             If the user doesn't type in any text inside textfield, create a warning alert to let the user know to type in the text.
            */
            let alertController = UIAlertController(title: "Warning",
                                                    message: "Please type in new email.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(alertAction)

            present(alertController, animated: true, completion: nil)

            return
        }
        
    }
}
