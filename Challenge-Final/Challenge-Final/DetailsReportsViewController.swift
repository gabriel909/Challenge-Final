//
//  DetailsReportsViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 26/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class DetailsReportsViewController: UIViewController {
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var attachmentLabel: UILabel!
    @IBOutlet weak var anexoLabel: UILabel!
    @IBOutlet weak var statusStack: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var photoCollectionArray: [UIImage]! = []
    
    var report: Denuncia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadLabels()
        self.collectionSetup()
        self.changeStatusColor()
        
        if !photoCollectionArray.isEmpty {
            attachmentLabel.isHidden = true
        }
        
        title = report.categoria.rawValue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func loadLabels() {
        descTextView.text = report.descricao
        statusLabel.text = report.status.rawValue
        
    }
    
    private func changeStatusColor() {
        var color = UIColor()
        
        switch report.status {
            case .andamento:
                color = UIColor(rgb: 0xBBB500)
            
            case .resolvido:
                color = UIColor(rgb: 0x30D284)
            
            case .nao_resolvido:
                color = UIColor(rgb: 0xBB0000)
        }
        
        statusLabel.textColor = color
    }
    
    private func collectionSetup() {
        self.photoCollectionArray = self.getImageArray()
        
        self.collectionView.dataSource = self
    }
    
    private func getImageArray() -> [UIImage] {
        var array: [UIImage] = []
        
        if report.images != nil {
            for urlString in report.images! {
                let url = URL(string: "http://139.82.24.231:3000/\(urlString)")
                let data = try? Data(contentsOf: url!)
                let image: UIImage = UIImage(data: data!)!
                
                array.append(image)
            }
        }
        
        return array
    }
}

extension DetailsReportsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: NewReportCollectionViewCell
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newReportCell", for: indexPath as IndexPath) as! NewReportCollectionViewCell
        cell.imagem.image = photoCollectionArray[indexPath.row]
        
        return cell
    }
}
