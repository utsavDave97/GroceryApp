//
//  CategoryViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-30.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit
import Alamofire

class CategoryViewController: UIViewController
{
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var cartButton: UIButton!
    
    static let api = API()
    var categories = [Category]()
    
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    let categoriesImages: [UIImage] = [
        UIImage(named: "fruits.png")!,
        UIImage(named: "vegetables.png")!,
        UIImage(named: "meat.png")!,
        UIImage(named: "drinks.png")!,
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
        
        activityIndicator.startAnimating()
        
        CategoryViewController.api.getCategories { (categories) in
            
            self.categories = categories
            
            self.activityIndicator.stopAnimating()
            
            self.collectionView.reloadData()
        }
        
        //Set the delegate and datasource to self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        setUpButton()
    }
    
    private func setUpButton()
    {
        cartButton.layer.shadowColor = UIColor(red: 0.99, green: 0.03, blue: 0.30, alpha: 1.0).cgColor
        cartButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cartButton.layer.shadowOpacity = 1.0
        cartButton.layer.shadowRadius = 5
        cartButton.layer.masksToBounds = false
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "showProduct")
        {
            let productVC = segue.destination as! ProductsTableViewController
            if let cell = sender as? UICollectionViewCell,
                let indexPath = self.collectionView.indexPath(for: cell)
            {
                let category = categories[indexPath.row]
                productVC.categoryId = category.id
            }
        }
    }
}

//MARK: CollectionView Datasource
extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.imageView.image = categoriesImages[indexPath.row]
        cell.label.text = categories[indexPath.row].name
        
        //Applying shadow to cell
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cell.layer.shadowOpacity = 0.6
        cell.layer.shadowRadius = 1
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 5
        
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
