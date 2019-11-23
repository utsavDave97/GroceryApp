//
//  SettingsTableViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-26.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate
{
    private enum SettingSection: Int
    {
      case contacts = 0
      case version = 2
      
      static func cellIdentifier(for section: SettingSection) -> String {
        switch section {
        case .contacts:
          return "contactCell"
        case .version:
          return "versionCell"
        }
      }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == SettingSection.contacts.rawValue
        {
          return 3
        }
        else
        {
          return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(indexPath.section == 0)
        {
            if(indexPath.item == 0)
            {
                let email = "utsavdave1997@gmail.com"
                if let url = URL(string: "mailto:\(email)")
                {
                    if #available(iOS 10.0, *) {
                      UIApplication.shared.open(url)
                    } else {
                      UIApplication.shared.openURL(url)
                    }
                }
            }
            else if(indexPath.item == 1)
            {
                if let url = URL(string: "tel://5195195199")
                {
                    if #available(iOS 10.0, *) {
                      UIApplication.shared.open(url)
                    } else {
                      UIApplication.shared.openURL(url)
                    }
                }
            }
            else
            {
                let email = "utsavdave1997@gmail.com"
                if let url = URL(string: "mailto:\(email)")
                {
                    if #available(iOS 10.0, *) {
                      UIApplication.shared.open(url)
                    } else {
                      UIApplication.shared.openURL(url)
                    }
                }
            }
        }
    }
    /*
     Height for each cell
     */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
}
