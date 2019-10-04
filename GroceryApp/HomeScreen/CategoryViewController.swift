//
//  CategoryViewController.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-30.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController
{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var cartButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Set the delegate and datasource to self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Create settings button with the image
        let settingsButton = UIBarButtonItem(image: UIImage(named:"settings.png"), style: .plain, target: self, action: #selector(settingsPressed))
        
        //Set the tint color of settings button
        settingsButton.tintColor = UIColor.black
        
        //Set the rightbar button of navigation item to be settings
        self.navigationItem.rightBarButtonItem = settingsButton
        navBar.setItems([navigationItem], animated: false)

        // Do any additional setup after loading the view.
        setUpButton()
    }
    
    @IBAction func cartButtonTapped(_ sender: Any)
    {
        
    }
    
    private func setUpButton()
    {
        cartButton.layer.shadowColor = UIColor(red: 0.99, green: 0.03, blue: 0.30, alpha: 1.0).cgColor
        cartButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cartButton.layer.shadowOpacity = 1.0
        cartButton.layer.shadowRadius = 5
        cartButton.layer.masksToBounds = false
    }
    
    @objc private func settingsPressed()
    {
        print("Testt")
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

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (collectionView.bounds.width - 10 - 20*2)/2, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.imageView.image = UIImage(named: "dairy.png")
        cell.label.text = "Dairy"
        
        //Applying shadow to cell
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cell.layer.shadowOpacity = 0.6
        cell.layer.shadowRadius = 1
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 5
        
        cell.backgroundColor = UIColor.init(red: 214, green: 214, blue: 214, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
