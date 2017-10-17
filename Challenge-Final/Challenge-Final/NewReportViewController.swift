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
    
    fileprivate var plusIndex: Int = 0
    fileprivate var photoCollectionArray: [UIImage] = []
    fileprivate let picker: UIImagePickerController? = UIImagePickerController()
    fileprivate var tap = UITapGestureRecognizer()
    fileprivate var placeholder: String!
    
    fileprivate let sharedDAO = DAO.sharedDAO
    
    fileprivate var collectionView: UICollectionView!
    
    var category: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker?.delegate = self
        descricaoTextView.delegate = self
        self.collectionSetup()
        self.setTextViewPlaceholder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Aux Methods
    private func collectionSetup() {
        let collectionViewRect = CGRect(x: 0, y: 439, width: width, height: 110)
        let collectionViewCellNib = UINib(nibName: "NewReportCollectionViewCell", bundle: nil)
        
        self.collectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: createLayout())
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: "newReportCell")
        self.collectionView.clipsToBounds = true
        
        self.contentView.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let top_bottom = width / 10.76
        let right_left = width / 13
        layout.sectionInset = UIEdgeInsets(top: top_bottom, left: right_left, bottom: top_bottom, right: right_left)
        layout.itemSize = CGSize(width: width / 2.46, height: height / 4.46)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    private func setTextViewPlaceholder() {
        placeholder = "Digite aqui a descrição..."
        descricaoTextView.delegate = self
        descricaoTextView.text = placeholder
        descricaoTextView.textColor = UIColor.lightGray
    }
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
        if !descricaoTextView.text.isEmpty {
            let base64Array = Base64Enconder.encode(imgs: photoCollectionArray)
            let denuncia = Denuncia(categoria: .Acessibilidade, descricao: descricaoTextView.text!, date: "", status: .andamento, images: base64Array, videos: nil)
            
            let aluno = sharedDAO.aluno!
        
            sharedDAO.sendDenuncia(denuncia: denuncia, idAluno: aluno.id!, idEscola: aluno.escola_id, completion: { denuncia in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
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
        
        if plusIndex == indexPath.row {
            //MARK: - TODO Set Plus image
            
        } else {
            cell.imagem.image = photoCollectionArray[indexPath.row]
            
        }
        
        return cell
    }
}

//MARK: - Table View Delegate
extension NewReportViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
        
        photoCollectionArray.append(image!)
        plusIndex += 1
        self.collectionView.reloadData()
    }
}

extension NewReportViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textField: UITextView) {
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
        }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        self.contentView.addGestureRecognizer(tap)
    }
    
    func textViewDidEndEditing(_ textField: UITextView) {
        if textField.text.isEmpty {
            textField.text = placeholder
            textField.textColor = UIColor.lightGray
        }
        
        self.contentView.removeGestureRecognizer(tap)
    }
    
    @objc private func tapped(){
        contentView.endEditing(true)
    }
}
