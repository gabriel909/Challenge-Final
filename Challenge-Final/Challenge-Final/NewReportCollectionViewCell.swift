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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }

}
