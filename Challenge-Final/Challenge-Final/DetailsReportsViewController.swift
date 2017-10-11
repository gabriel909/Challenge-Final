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
    
    var report: Denuncia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func loadLabels() {
        titleLabel.text = report.categoria.rawValue
        descTextView.text = report.descricao
        statusLabel.text = report.status.rawValue
    }
}
