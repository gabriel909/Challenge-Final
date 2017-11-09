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
    @IBOutlet weak var gambiarraLuisa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imagem.clipsToBounds = true
        imagem.layer.masksToBounds = true
        
        viewCell.layer.cornerRadius = 10
        //MARK: TROCAR ESSA PORRA
//        self.gambiarraLuisa.isHidden = true
        
//        imagem.layer.cornerRadius = 15
    }

}
