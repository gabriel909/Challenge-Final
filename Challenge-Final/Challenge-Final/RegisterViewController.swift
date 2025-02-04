//
//  RegisterViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 11/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

//MARK: - TODO Mudar esta merda
var gambi: Escola! = Escola()

import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var schoolTextField: SkyFloatingLabelTextField!
    @IBOutlet var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet var confirmPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet var yearTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var avatarLabel: UILabel!
    
    fileprivate var sharedDAO = DAO.sharedDAO
    fileprivate var selectedAvatar: IndexPath? = nil
    
    var chosenSchool: String!
    var alunoUpdate: Aluno!
    
    var collectionLayout: UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let top_bottom = width / 10.76
        let right_left = width / 13
        layout.sectionInset = UIEdgeInsets(top: top_bottom, left: right_left, bottom: top_bottom, right: right_left)
        layout.itemSize = CGSize(width: height / 4.73, height: height / 4.73)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    lazy var collectionView: UICollectionView! = {
        var collectionViewCellNib = UINib(nibName: "NewReportCollectionViewCell", bundle: nil)
        let collectionViewRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        let collection = UICollectionView(frame: collectionViewRect, collectionViewLayout: collectionLayout)
        
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.clipsToBounds = true
        collection.register(collectionViewCellNib, forCellWithReuseIdentifier: "newReportCell")
        
        return collection
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.schoolTextField.delegate = self
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.yearTextField.delegate = self
        
        if alunoUpdate != nil {
            self.setLabels()
        }
      
        title = "Cadastro"
        
        self.contentView.addSubview(collectionView)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barStyle = .black
//        self.navigationController?.navigationBar.transparentNavigationBar()
//        self.navigationController?.navigationItem.title = "Cadastro"
        
        if alunoUpdate == nil {
            schoolTextField.text = gambi.nomeEscola
        }
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
    
    override func viewDidLayoutSubviews() {
        let collectionY = (avatarLabel.layer.position.y + (avatarLabel.frame.height / 2)) + (width / 16)
        collectionView.frame = CGRect(x: 0, y: collectionY, width: width, height: height / 4.73)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    @IBAction func unWindToViewController(sender: UIStoryboardSegue) {
        let sourceVC = sender.source as! SchoolListViewController
        self.chosenSchool = sourceVC.selected
        self.schoolTextField.text = chosenSchool
    }
    
    @IBAction func signupButton(_ sender: Any) {
        if (schoolTextField.text?.isEmpty)! ||
           (nameTextField.text?.isEmpty)! ||
           (emailTextField.text?.isEmpty)! ||
           (passwordTextField.text?.isEmpty)! ||
           (confirmPasswordTextField.text?.isEmpty)! ||
           (yearTextField.text?.isEmpty)! {
            
            message("Atenção", desc: "Por favor preencha todos os campos", view: self)
            
        } else if passwordTextField.text != confirmPasswordTextField.text {
            message("Atenção", desc: "As senhas não são iguais", view: self)
            
        } else {
            let aluno = getAlunoFromLabels()
            
            sharedDAO.create(aluno: aluno, escola_id: gambi.id, completion: { (aluno_completion) in
                DispatchQueue.main.async {
                    self.sharedDAO.set(aluno: aluno_completion)
                    self.performSegue(withIdentifier: "signupToMain", sender: self)
                }
            })
        }
    }
    
    //MARK: - Aux Methods
    private func setLabels() {
        nameTextField.text = alunoUpdate.name
        emailTextField.text = alunoUpdate.email
        selectedAvatar?.row = alunoUpdate.avatar!
        collectionView.reloadData()
        yearTextField.text = alunoUpdate.serie
        schoolTextField.text = alunoUpdate.escolaNome
    }
    
    private func getAlunoFromLabels() -> Aluno {
        let aluno = Aluno()
        
        aluno.name = nameTextField.text!
        aluno.email = emailTextField.text!
        aluno.avatar = selectedAvatar?.row
        aluno.password = passwordTextField.text!
        aluno.serie = yearTextField.text!
        
        return aluno
    }
}

//MARK: - Extensions
//MARK: TextField Delegate
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField.tag == 1 {
            self.contentView.endEditing(true)
            performSegue(withIdentifier: "toSchoolList", sender: self)

        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        if textField.tag == 1 {
            textField.text = chosenSchool

        }
    }
}

//MARK: Collection Delegate
extension RegisterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! NewReportCollectionViewCell
        
        if selectedAvatar != nil {
            let cell = collectionView.cellForItem(at: selectedAvatar!) as! NewReportCollectionViewCell
            cell.imagem.layer.borderWidth = 0
        }
        
        self.selectedAvatar = indexPath
        selectedCell.imagem.layer.borderWidth = 2
        selectedCell.imagem.layer.borderColor = UIColor.white.cgColor
    }
}

//MARK: Collection Data Source
extension RegisterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newReportCell", for: indexPath as IndexPath) as! NewReportCollectionViewCell
        
        cell.imagem.image = UIImage(named: "avatar\(indexPath.row)")
        cell.imagem.contentMode = .center
        cell.viewCell.backgroundColor = .clear
        cell.gambiarraLuisa.isHidden = true
        
        return cell
    }
}
