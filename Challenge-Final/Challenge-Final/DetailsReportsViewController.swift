//
//  DetailsReportsViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 26/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class DetailsReportsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var statusLabel: UILabel!
    
    fileprivate var collectionView: UICollectionView!
    fileprivate var photoCollectionArray: [UIImage]! = []
    
    var report: Denuncia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadLabels()
        self.collectionSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func loadLabels() {
        titleLabel.text = report.categoria.rawValue
        descTextView.text = report.descricao
        statusLabel.text = report.status.rawValue
    }
    
    private func collectionSetup() {
        let collectionViewRect = CGRect(x: 0, y: height / 2.31, width: width, height: height / 5.16)
        let collectionViewCellNib = UINib(nibName: "NewReportCollectionViewCell", bundle: nil)
        
        self.photoCollectionArray = self.getImageArray()
        
        self.collectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: createLayout())
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: "newReportCell")
        self.collectionView.clipsToBounds = true
        
        self.view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let top_bottom = width / 10.76
        let right_left = width / 13
        layout.sectionInset = UIEdgeInsets(top: top_bottom, left: right_left, bottom: top_bottom, right: right_left)
        layout.itemSize = CGSize(width: width / 2.46, height: height / 4.46)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    private func getImageArray() -> [UIImage] {
        var array: [UIImage] = []
        
        print("IMAGES ARRAY \(report.images!.count)")
        
        for urlString in report.images! {
            let url = URL(string: urlString)
            let data = try? Data(contentsOf: url!)
            let image: UIImage = UIImage(data: data!)!
            
            array.append(image)
        }
        
        return array
    }
}

extension DetailsReportsViewController: UICollectionViewDelegate {
    
}

extension DetailsReportsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photoCollectionArray.count)
        return photoCollectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: NewReportCollectionViewCell
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newReportCell", for: indexPath as IndexPath) as! NewReportCollectionViewCell
        cell.imagem.image = photoCollectionArray[indexPath.row]
        
        return cell
    }
}
