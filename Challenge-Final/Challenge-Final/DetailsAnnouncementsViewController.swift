//
//  DetailsAnnouncementsViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 26/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class DetailsAnnouncementsViewController: UIViewController {

    @IBOutlet weak var avisoImage: UIImageView!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var aviso: Aviso!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLabels()

    }
    
    private func loadLabels() {
        descTextView.text = aviso.descricao
        titleLabel.text = aviso.titulo
        
        if aviso.image != nil {
            //MARK: - TODO Set aviso image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
