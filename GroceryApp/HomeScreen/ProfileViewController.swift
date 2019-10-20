//
//  ProfileViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-30.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController
{
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        else
        {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "deleteAccount")!
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
}
