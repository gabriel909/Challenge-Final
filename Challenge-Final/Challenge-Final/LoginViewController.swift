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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cadastroBtn.layer.borderWidth = 1
        
//        self.checkIfUserIsLoggedIn()
        self.hideKeyboardWhenTappedAround()
    
        print("\(width) \(height)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Aux Methods
    private func checkIfUserIsLoggedIn() {
        let aluno = sharedDAO.getLoggedAluno()
        
        if aluno != nil {
            login(email: (aluno?.email)!, password: (aluno?.password)!)
        }
    }
    
    private func login(email: String, password: String) {
        sharedDAO.loginAluno(email: email_label.text!, password: password_label.text!, completion: { (aluno, error) in
            if error == nil && aluno != nil {
                self.sharedDAO.set(aluno: aluno!)
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "login_to_main", sender: self)
                }
                
            } else {
                if error == Errors.invalidCredentials.rawValue {
                    message("Atenção", desc: "Email ou senha inválidos", view: self)
                }
            }
        })
    }
    
    //MARK: - Actions
    @IBAction func next_button_action(_ sender: UIButton) {
        sender.animateButton()
        
        if (email_label.text?.isEmpty)! || (password_label.text?.isEmpty)! {
            message("Atenção", desc: "O email ou a senha não podem estar em branco", view: self)
            
        } else {
            self.view.endEditing(true)
            
            login(email: email_label.text!, password: password_label.text!)
        }
    }
    
    @IBAction func signupButtonAction(_ sender: UIButton) {
        sender.animateButton()
    }
}
