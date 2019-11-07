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
    //MARK: Outlets
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartButton: UIButton!
    
    //Declare the api
    static let api = API()
    
    //Create an array of categories
    var categories = [Category]()
    
    //Initialize the activity indicator view
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    //Get the images from assets folder and create an array of UIImage
    let categoriesImages: [UIImage] = [
        UIImage(named: "fruits.png")!,
        UIImage(named: "vegetables.png")!,
        UIImage(named: "meat.png")!,
        UIImage(named: "drinks.png")!,
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Add activity indicator view
        view.addSubview(activityIndicator)
        
        //Set the color and its hide and stop
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        
        //Position the activity indicator view to the center of the VC
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
        
        //Start animating the activity indicator before data loads up
        activityIndicator.startAnimating()
        
        //Call the getCategories method from API File inside Helpers folder
        CategoryViewController.api.getCategories { (categories) in
            
            self.categories = categories
            
            //Stop animating the activity indicator after the data is received
            self.activityIndicator.stopAnimating()
            
            //Reload the collection view again after getting the data
            self.collectionView.reloadData()
        }
        
        //Set the delegate and datasource to self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        setUpButton()
    }
    
    /*
    This method sets up cart button on this view controller.
    It creates a shadow with offset, opacity and shadow color.
    */
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
        //If the identifier is showProduct than move to ProductsTableVC
        if(segue.identifier == "showProduct")
        {
            //Create a destination
            let productVC = segue.destination as! ProductsTableViewController
            
            //Get the cell and its indexPath
            if let cell = sender as? UICollectionViewCell,
                let indexPath = self.collectionView.indexPath(for: cell)
            {
                //Get the category by its indexPath
                let category = categories[indexPath.row]
                
                //assign the id of category of ProductVC to id of category cell which was clicked
                productVC.categoryId = category.id
            }
        }
    }
}

//MARK: CollectionView Datasource
extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        //Create a cell and typecast it to CategoryCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        //Set the cell's image and text to appropriate
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

//MARK: CollectionViewDelegateFlowLayout
extension CategoryViewController: UICollectionViewDelegateFlowLayout
{
    //Method to create a minimum spacing between each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
