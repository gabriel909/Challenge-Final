//
//  ViewController.swift
//  Challenge-Final
//
//  Created by Gabriel Oliveira on 28/8/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {
    @IBOutlet weak var email_label: SkyFloatingLabelTextField!
    @IBOutlet weak var password_label: SkyFloatingLabelTextField!
    @IBOutlet weak var cadastroBtn: CustomButton!
    
    private let sharedDAO = DAO.sharedDAO
    private let sharedCodingManager = NSCodingManager.sharedCodingManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cadastroBtn.layer.borderWidth = 1
        
        self.checkIfUserIsLoggedIn()
        
        print("\(width) \(height)")
        
    }
    
    private func checkIfUserIsLoggedIn() {
        let aluno = sharedDAO.getLoggedAluno()
        
        if aluno != nil {
            self.performSegue(withIdentifier: "login_to_main", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next_button_action(_ sender: Any) {
        if (email_label.text?.isEmpty)! || (password_label.text?.isEmpty)! {
            message("Atenção", desc: "O email ou a senha não podem estar em branco", view: self)
            
        } else {
            self.view.endEditing(true)
            
            sharedDAO.loginAluno(email: email_label.text!, password: password_label.text!, completion: { (aluno, error) in
                if error == nil && aluno != nil {
                    self.sharedDAO.set(aluno: aluno!)
                    print(aluno?.escola_id)

                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "login_to_main", sender: self)
                    }

                } else {
                    message("Atenção", desc: "Deu Merda", view: self)
                    
                }
            })
        }
    }
}
