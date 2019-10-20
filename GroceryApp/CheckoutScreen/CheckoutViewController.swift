//
//  CheckoutViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-10-19.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import Stripe

class CheckoutViewController: UIViewController
{
    private enum Section: Int
    {
      case products = 0
      case total
      
      static func cellIdentifier(for section: Section) -> String {
        switch section {
        case .products:
          return "cartCell"
        case .total:
          return "totalCell"
        }
      }
    }
    
    //MARK: Outlets
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButton()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Cart"
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setUpButton()
    {
        continueButton.layer.shadowColor = UIColor.black.cgColor
        continueButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        continueButton.layer.shadowOpacity = 0.5
        continueButton.layer.shadowRadius = 5
        continueButton.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 7
    }
    
    @IBAction func continueButtonTapped(_ sender: Any)
    {
        guard CheckoutCart.shared.canPay else
        {
            let alertController = UIAlertController(title: "Warning",
                                                    message: "Your cart is empty!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(alertAction)

            present(alertController, animated: true, completion: nil)

            return
        }
        
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        
        let navCon = UINavigationController(rootViewController: addCardViewController)
        present(navCon, animated: true, completion: nil)
    }
    
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

//MARK: TableViewDelegate Methods
extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == Section.products.rawValue
        {
          return CheckoutCart.shared.cart.count
        }
        else
        {
          return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let section = Section(rawValue: indexPath.section) else {
          fatalError("Section not found")
        }
        
        let identifier = Section.cellIdentifier(for: section)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        switch cell
        {
        case let cell as CartCell:
            let product = CheckoutCart.shared.cart[indexPath.row]
            cell.configure(with: product)
            
        case let cell as TotalCell:
            let total = CheckoutCart.shared.total
            cell.configure(with: total)
//            let total = CheckoutCart.shared.total
//            cell.configure(with: total)
            
        default:
            fatalError("Cell does not match the correct type")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        if indexPath.section == Section.products.rawValue
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        guard editingStyle == .delete else {
            return
        }
        
        let product = CheckoutCart.shared.cart[indexPath.row]
        let isRemoved = CheckoutCart.shared.removeProduct(product)
        
        if isRemoved
        {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            tableView.endUpdates()
        }
    }
}

//MARK: StripeDelegate Methods
extension CheckoutViewController: STPAddCardViewControllerDelegate
{
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController)
    {
        navigationController?.popViewController(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock)
    {
        
    }
    
}
