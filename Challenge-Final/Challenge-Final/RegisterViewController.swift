//
//  RegisterViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 11/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

//MARK: - TO DO: Mudar esta merda
var gambi: String!

import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController {
    
    @IBOutlet var schoolTextField: SkyFloatingLabelTextField!
    @IBOutlet var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet var confirmPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet var yearTextField: SkyFloatingLabelTextField!
    
    var chosenSchool: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.schoolTextField.delegate = self
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.yearTextField.delegate = self
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.transparentNavigationBar()
        self.navigationController?.navigationItem.title = "Cadastro"
        schoolTextField.text = gambi


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unWindToViewController(sender: UIStoryboardSegue) {
        let sourceVC = sender.source as! SchoolListViewController
        self.chosenSchool = sourceVC.selected
        self.schoolTextField.text = chosenSchool
        print(chosenSchool)

    }
    @IBAction func signupButton(_ sender: Any) {
        if (schoolTextField.text?.isEmpty)! ||
           (nameTextField.text?.isEmpty)! ||
           (emailTextField.text?.isEmpty)! ||
           (passwordTextField.text?.isEmpty)! ||
           (confirmPasswordTextField.text?.isEmpty)! ||
           (yearTextField.text?.isEmpty)! {
            
            message("Atenção", desc: "Por favor preencha todos os campos", view: self)
            
        } else {
            performSegue(withIdentifier: "signupToMain", sender: self)
            
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 1 {
            self.view.endEditing(true)
            performSegue(withIdentifier: "toSchoolList", sender: self)
        
        } else {
        
            animateViewMoving(true, moveValue: 150)
            
        }
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField.tag == 1 {
//            return false
//
//        }
//
//        return true
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 1 {
            textField.text = chosenSchool
        
        } else {
            
            animateViewMoving(false, moveValue: 150)
        
        }
    }
    
    func animateViewMoving(_ up: Bool, moveValue: CGFloat){
        let movementDuration: TimeInterval = 0.3
        let movement: CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
