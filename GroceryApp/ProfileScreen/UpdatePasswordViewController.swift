//
//  UpdatePasswordViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-21.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UpdatePasswordViewController: UIViewController
{
    //MARK: Properties
    var userEmail: String = ""
    var userPassword: String = ""
    
    //MARK: Outlets
    @IBOutlet weak var updatePasswordButton: UIButton!
    {
        didSet
        {
            updatePasswordButton.layer.cornerRadius = 7
            updatePasswordButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var currentPasswordTextfield: UITextField!
    @IBOutlet weak var newPasswordTextfield: UITextField!
    
    /*
    Inside viewDidLoad get the email and password from UserDefaults
    and set the value of userEmail and userPassword to that value received for that key.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmail = UserDefaults.standard.string(forKey: "email")!
        userPassword = UserDefaults.standard.string(forKey: "password")!
    }
    
    @IBAction func updatePasswordButtonTapped(_ sender: Any)
    {
        /*
         create a credential with the help of values got from UserDefaults for email and password.
        */
        let credential = EmailAuthProvider.credential(withEmail: self.userEmail, password: self.userPassword)
        
        /*
         Check if there is string inside new password text field and check if it is empty or not.
        */
           if let newPassword = newPasswordTextfield.text, !newPassword.isEmpty
           {
                /*
                 Get the current user with the help of Firebase's Auth object
                */
               if let currentUser = Auth.auth().currentUser
               {
                  /*
                   In order to update user's password, we first need to reauthenticate user as this kind of actions require user's consent.
                  */
                   currentUser.reauthenticate(with: credential) { (result, error) in
                       if let error = error
                       {
                           print(error)
                       }
                       else
                       {
                           /*
                            Use the updatePassword method of Firebase to update password, which takes in new password and a completion handler
                           */
                           currentUser.updatePassword(to: newPassword, completion: { (error) in
                               if let error = error
                               {
                                //If there are any errors, print the cause of error
                                   print(error)
                               }
                               else
                               {
                                //If the operation was a success than, take the user back to log in screen and make him log in again with new password
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
                                                       message: "Please type in required fields.", preferredStyle: .alert)
               let alertAction = UIAlertAction(title: "OK", style: .default)
               alertController.addAction(alertAction)

               present(alertController, animated: true, completion: nil)

               return
           }
    }
}
