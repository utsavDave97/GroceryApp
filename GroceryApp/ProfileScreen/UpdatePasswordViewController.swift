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
    var userEmail: String = ""
    var userPassword: String = ""
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmail = UserDefaults.standard.string(forKey: "email")!
        userPassword = UserDefaults.standard.string(forKey: "password")!
    }
    
    @IBAction func updatePasswordButtonTapped(_ sender: Any)
    {
        let credential = EmailAuthProvider.credential(withEmail: self.userEmail, password: self.userPassword)
        
           if let newPassword = newPasswordTextfield.text, !newPassword.isEmpty
           {
               if let currentUser = Auth.auth().currentUser
               {
                   currentUser.reauthenticate(with: credential) { (result, error) in
                       if let error = error
                       {
                           print(error)
                       }
                       else
                       {
                           currentUser.updatePassword(to: newPassword, completion: { (error) in
                               if let error = error
                               {
                                   print(error)
                               }
                               else
                               {
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
               let alertController = UIAlertController(title: "Warning",
                                                       message: "Please type in required fields.", preferredStyle: .alert)
               let alertAction = UIAlertAction(title: "OK", style: .default)
               alertController.addAction(alertAction)

               present(alertController, animated: true, completion: nil)

               return
           }
    }
}
