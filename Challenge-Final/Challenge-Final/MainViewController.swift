//
//  MainViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 21/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serieLabel: UILabel!
    @IBOutlet weak var escolaLabel: UILabel!
    @IBOutlet weak var echobtn: CustomButton!
    @IBOutlet weak var avisobtn: CustomButton!
    
    fileprivate let sharedDAO = DAO.sharedDAO
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        echobtn.layer.borderWidth = 1
        avisobtn.layer.borderWidth = 1
        
        self.setLabels()
    }
    
    @IBAction func profileEdit(_ sender: Any) {
        performSegue(withIdentifier: "mainToSignup", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController = segue.destination as! RegisterViewController
        destViewController.alunoUpdate = sharedDAO.aluno
    }
    
    private func setLabels() {
        nameLabel.text = sharedDAO.aluno?.name
        print(sharedDAO.aluno?.escolaNome)
        serieLabel.text = "\(sharedDAO.aluno!.serie) ano"
        escolaLabel.text = sharedDAO.aluno?.escolaNome
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBAction func echoButtonAction(_ sender: UIButton) {
        sender.animateButton()
    }
    
    @IBAction func avisosActionButton(_ sender: UIButton) {
        sender.animateButton()
    }
}
