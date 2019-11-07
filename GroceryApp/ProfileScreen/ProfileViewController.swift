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
    //MARK: Properties
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
        
        //Set the delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        //get the values of user's email and password from UserDefaults
        userEmail = UserDefaults.standard.string(forKey: "email")!
        userPassword = UserDefaults.standard.string(forKey: "password")!

        // Do any additional setup after loading the view.
        setUpButton()
    }
    
    /*
     perform a segue when the cart button is tapped which will take the user to CheckoutViewController
     */
    @IBAction func cartButtonTapped(_ sender: Any)
    {
        self.performSegue(withIdentifier: "checkoutSegue2", sender: sender)
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any)
    {
        
    }
    
    /*
     This method sets up cart button on this view controller.
     It creates a shadow with offset, opacity and shadow color.
     */
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
        /*
         create a credential with the help of values got from UserDefaults for email and password.
        */
        let credential = EmailAuthProvider.credential(withEmail: self.userEmail, password: self.userPassword)
        
        /*
         Get the current user with the help of Firebase's Auth object
        */
        if let currentUser = Auth.auth().currentUser
        {
            /*
             In order to delete user's account, we first need to reauthenticate user as this kind of major actions require user's consent.
            */
            currentUser.reauthenticate(with: credential) { (result, error) in
                if let error = error
                {
                    //print any errors
                    print(error)
                }
                else
                {
                    /*
                     Use the delete method of Firebase to delete account
                    */
                    currentUser.delete { (error) in
                        if let error = error
                        {
                            print("Error deleting user: \(error)")
                        }
                        else
                        {
                            //If the operation was a success than, take the user back to log in screen
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

//MARK: TableViewDelegate Methods, TableViewDataSource Methods
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource
{
    //Get the number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    /*
     Check for indexPath item and than return the subsequent cell
    */
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
        /*
         if the user selects delete account cell
        */
        if(indexPath.item == 2)
        {
            //Present delete alert if the user wants to delete the account
            let alertController = UIAlertController(title: "Delete",
                                                    message: "Are you sure you want to delete account?", preferredStyle: .alert)
            
            //The action would call deleteAccount method
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                
                self.deleteAccount()
                
            })
            
            //Cancel action would just cancel the alert dialog
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)

            //present the controller
            present(alertController, animated: true, completion: nil)

            return
        }
        
        /*
         if the user selects log out cell
        */
        if(indexPath.item == 3)
        {
            //Sign out the user with the help of signOut method of Auth of Firebase
            try! Auth.auth().signOut()
            
            //Take the user back to login screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController {
                loginVC.modalPresentationStyle = .fullScreen
                present(loginVC, animated: true, completion: nil)
            }
        }
    }
    
    //Provide height for each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
}
