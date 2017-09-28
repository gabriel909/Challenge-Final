//
//  SchoolsTableViewCell.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 18/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class SchoolsTableViewCell: UITableViewCell {

    @IBOutlet weak var schoolName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
