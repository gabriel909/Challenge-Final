//
//  CategoriesViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 26/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    private var collectionview: UICollectionView!
    var selected: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.collectionSetup()
        self.collectionview.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.transparentNavigationBar()
        
        
    }
    
    //MARK: - Aux Methods
    private func collectionSetup() {
        let collectionViewRect = CGRect(x: 0, y: 0, width: width, height: height)
        let collectionViewCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        let layout = UICollectionViewFlowLayout()
        
        self.collectionview = UICollectionView(frame: collectionViewRect, collectionViewLayout: layout)
        self.collectionview.dataSource = self
        self.collectionview.backgroundColor = .clear
        self.collectionview.register(collectionViewCellNib, forCellWithReuseIdentifier: "idCatCell")
        self.collectionview.clipsToBounds = true
        
        self.view.addSubview(collectionview)
    }
    
}

//MARK: - Extensions
//MARK: - Table View Data Source
extension CategoriesViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: CollectionViewCell
        
        cell = collectionview.dequeueReusableCell(withReuseIdentifier: "idCatCell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.backgroundColor = .clear
        cell.titleLabel.text = "Teste"
        cell.img.image = UIImage()
        
        return cell
    }
    

}

//MARK: - Table View Delegate
extension CategoriesViewController: UICollectionViewDelegate {
    

    
}



