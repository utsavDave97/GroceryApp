//
//  ProfileViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-30.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ProfileViewController: UIViewController
{
    var userEmail: String = ""
    var userPassword: String = ""
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        userEmail = UserDefaults.standard.string(forKey: "email")!
        userPassword = UserDefaults.standard.string(forKey: "password")!

        // Do any additional setup after loading the view.
        setUpButton()
    }
    
    @IBAction func cartButtonTapped(_ sender: Any)
    {
        self.performSegue(withIdentifier: "checkoutSegue2", sender: sender)
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any)
    {
        
    }
    
    private func setUpButton()
    {
       cartButton.layer.shadowColor = UIColor(red: 0.99, green: 0.03, blue: 0.30, alpha: 1.0).cgColor
       cartButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
       cartButton.layer.shadowOpacity = 1.0
       cartButton.layer.shadowRadius = 5
       cartButton.layer.masksToBounds = false
    }
    
    private func deleteAccount()
    {
        let credential = EmailAuthProvider.credential(withEmail: self.userEmail, password: self.userPassword)
        
        if let currentUser = Auth.auth().currentUser
        {
            currentUser.reauthenticate(with: credential) { (result, error) in
                if let error = error
                {
                    print(error)
                }
                else
                {
                    currentUser.delete { (error) in
                        if let error = error
                        {
                            print("Error deleting user: \(error)")
                        }
                        else
                        {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            if let loginVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController {
                                loginVC.modalPresentationStyle = .fullScreen
                                self.present(loginVC, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(indexPath.item == 0)
        {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "updateEmail")!
            return cell
        }
        else if(indexPath.item == 1)
        {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "updatePassword")!
            return cell
        }
        else if(indexPath.item == 2)
        {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "deleteAccount")!
            return cell
        }
        else
        {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "logOut")!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(indexPath.item == 0)
        {
            
        }
        else if(indexPath.item == 1)
        {
            
        }
        else if(indexPath.item == 2)
        {
            //Present delete alert if the user wants to delete the account
            let alertController = UIAlertController(title: "Delete",
                                                    message: "Are you sure you want to delete account?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                
                self.deleteAccount()
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)

            return
        }
        else
        {
            try! Auth.auth().signOut()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController {
                loginVC.modalPresentationStyle = .fullScreen
                present(loginVC, animated: true, completion: nil)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
}
