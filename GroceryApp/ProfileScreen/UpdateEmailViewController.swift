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
    var userEmail: String = ""
    var userPassword: String = ""
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmail = UserDefaults.standard.string(forKey: "email")!
        userPassword = UserDefaults.standard.string(forKey: "password")!
        
        currentEmailTextField.text = userEmail
        currentEmailTextField.isEnabled = false
    }
    
    @IBAction func updateEmailButtonTapped(_ sender: Any)
    {
        let credential = EmailAuthProvider.credential(withEmail: self.userEmail, password: self.userPassword)
     
        if let newEmail = newEmailTextField.text, !newEmail.isEmpty
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
                        currentUser.updateEmail(to: newEmail, completion: { (error) in
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
                                                    message: "Please type in new email.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(alertAction)

            present(alertController, animated: true, completion: nil)

            return
        }
        
    }
}
