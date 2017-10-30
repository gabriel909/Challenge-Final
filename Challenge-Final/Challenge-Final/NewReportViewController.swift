//
//  NewReportViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 26/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class NewReportViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var descricaoTextView: UITextView!
    @IBOutlet weak var cancelButtonOutlet: CustomButton!
    @IBOutlet weak var categoryButtonOutlet: CustomButton!
    
    fileprivate var plusIndex: Int = 0
    fileprivate var selectedIndex: Int = 0
    fileprivate var photoCollectionArray: [UIImage] = []
    fileprivate let picker: UIImagePickerController? = UIImagePickerController()
    fileprivate var tap = UITapGestureRecognizer()
    fileprivate var placeholder: String!
    
    fileprivate var new: Bool {
        get {
            return selectedIndex == 0
        }
    }
    
    fileprivate let sharedDAO = DAO.sharedDAO
    
    fileprivate var collectionView: UICollectionView!
    
    var category: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionSetup()
        self.setTextViewPlaceholder()
        self.elementsSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Aux Methods
    private func collectionSetup() {
        let collectionViewRect = CGRect(x: 0, y: 429, width: width, height: 120)
        let collectionViewCellNib = UINib(nibName: "NewReportCollectionViewCell", bundle: nil)
        
        self.collectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: createLayout())
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: "newReportCell")
        self.collectionView.clipsToBounds = true
        
        self.contentView.addSubview(collectionView)
    }
    
    private func elementsSetup() {
        self.cancelButtonOutlet.borderWidth = 1
        
        self.categoryButtonOutlet.setTitle(" \(category!)", for: .normal)
        
        self.picker?.delegate = self
        
        self.descricaoTextView.delegate = self
        self.descricaoTextView.cornerRadius = 10
        self.descricaoTextView.borderWidth = 1
        self.descricaoTextView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let top_bottom = width / 10.76
        let right_left = width / 13
        layout.sectionInset = UIEdgeInsets(top: top_bottom, left: right_left, bottom: top_bottom, right: right_left)
        layout.itemSize = CGSize(width: width / 2.9, height: height / 5)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    private func setTextViewPlaceholder() {
        placeholder = " Digite aqui a descrição..."
        descricaoTextView.delegate = self
        descricaoTextView.text = placeholder
        descricaoTextView.textColor = UIColor.white
    }
    
    //MARK: - Actions
    @IBAction func sendButtonAction(_ sender: UIButton) {
        if !descricaoTextView.text.isEmpty {
            let base64Array = Base64Enconder.encode(imgs: photoCollectionArray)
            let denuncia = Denuncia(categoria: Categoria(rawValue: category)!, descricao: descricaoTextView.text!, date: "", status: .andamento, images: base64Array, videos: nil)
            
            let aluno = sharedDAO.aluno!
        
            sharedDAO.sendDenuncia(denuncia: denuncia, idAluno: aluno.id!, idEscola: aluno.escola_id, completion: { denuncia in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Extensions
//MARK: - Table View Data Source
extension NewReportViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollectionArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: NewReportCollectionViewCell
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newReportCell", for: indexPath as IndexPath) as! NewReportCollectionViewCell
        
        if indexPath.row == 0 {
            cell.imagem.image = UIImage()
            
        } else {
            cell.imagem.image = photoCollectionArray[indexPath.row - 1]
            
        }
        
        return cell
    }
}

//MARK: - Table View Delegate
extension NewReportViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.openGalleryAlert()
    }
    
    private func openGalleryAlert() {
        var cameraAction: UIAlertAction
        var galleryAction: UIAlertAction
        var cancelAction: UIAlertAction
        
        let alertAction = UIAlertController(title: "Escolha a Imagem", message: nil, preferredStyle: .actionSheet)
        
        cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { alertActionBlock in
            self.openCamera()
        })
        
        galleryAction = UIAlertAction(title: "Galeria", style: .default, handler: { alertActionBlock in
            self.openGallery()
        })
        
        cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertAction.addAction(cameraAction)
        alertAction.addAction(galleryAction)
        alertAction.addAction(cancelAction)
        
        self.present(alertAction, animated: true, completion: nil)
    }
    
    //Method to open the phone gallery
    private func openGallery() {
        picker!.sourceType = .photoLibrary
        picker!.mediaTypes = ["public.image"]
        self.present(picker!, animated: true, completion: nil)
    }
    
    //Method to open the phone camera
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker!.sourceType = .camera
            self.present(picker!, animated: true, completion: nil)
            
        } else {
            message("Atenção", desc: "O dispositivo não possui camera", view: self)
            
        }
    }
}

//MARK: - Image Picker Delegate
extension NewReportViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        picker.dismiss(animated: true, completion: nil)
        
        print("NEW \(new)")
        
        if new {
            photoCollectionArray.append(image!)
            
        } else {
            print("SELECTED INDEX \(selectedIndex)")
            photoCollectionArray[selectedIndex - 1] = image!
            
        }
        
        self.collectionView.reloadData()
    }
}

extension NewReportViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textField: UITextView) {
        if textField.text == placeholder {
            textField.text = nil
        }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        self.contentView.addGestureRecognizer(tap)
    }
    
    func textViewDidEndEditing(_ textField: UITextView) {
        if textField.text.isEmpty {
            textField.text = placeholder
        }
        
        self.contentView.removeGestureRecognizer(tap)
    }
    
    @objc private func tapped(){
        contentView.endEditing(true)
    }
}
