//
//  NewReportCollectionViewCell.swift
//  Challenge-Final
//
//  Created by Gabriel Oliveira on 10/10/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class NewReportCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imagem.clipsToBounds = true
        imagem.layer.masksToBounds = true
        
//        imagem.layer.cornerRadius = 15
    }

}
