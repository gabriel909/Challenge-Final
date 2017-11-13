//
//  DetailsAnnouncementsViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 26/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class DetailsAnnouncementsViewController: UIViewController {
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var avisoImage: UIImageView!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var attachmentLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
//    fileprivate var collectionView: UICollectionView!
    fileprivate var photoCollectionArray: [UIImage]! = []
    fileprivate var selectedIndex: Int = -1
    
    var aviso: Aviso!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadLabels()
        self.collectionSetup()
        
        title = aviso.titulo
        
        if !photoCollectionArray.isEmpty {
            attachmentLabel.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Aux Methods
    private func loadLabels() {
        descTextView.text = aviso.descricao
        dataLabel.text = aviso.data.getFormattedDate()
        print(aviso.data)
    }
    
    private func collectionSetup() {
        self.photoCollectionArray = self.getImageArray()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    private func getImageArray() -> [UIImage] {
        var array: [UIImage] = []
        
        if aviso.images != nil {
            for urlString in aviso.images! {
                let url = URL(string: "http://139.82.24.231:3000/\(urlString)")
                let data = try? Data(contentsOf: url!)
                let image: UIImage = UIImage(data: data!)!
                
                array.append(image)
            }
        }
        
        return array
    }
}

//MARK: - Extensions
//MARK: Collection Delegate
extension DetailsAnnouncementsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openAlert(indexPath.row)
        selectedIndex = indexPath.row
    }
    
    private func openAlert(_ index: Int) {
        var saveAction: UIAlertAction
        var seeAction: UIAlertAction
        var cancelAction: UIAlertAction
        let photo: UIImage = photoCollectionArray[index]
        
        let alertAction = UIAlertController(title: "Escolha a Imagem", message: nil, preferredStyle: .actionSheet)
        
        saveAction = UIAlertAction(title: "Salvar", style: .default, handler: { _ in
            self.saveIntoGallery(photo)
        })
        
        seeAction = UIAlertAction(title: "Ver", style: .default, handler: { _ in
            self.seePicture(photo)
        })
        
        cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertAction.addAction(saveAction)
        alertAction.addAction(seeAction)
        alertAction.addAction(cancelAction)
        
        self.present(alertAction, animated: true, completion: nil)
    }
    
    private func saveIntoGallery(_ photo: UIImage) {
        UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil)
        
        message("Atenção", desc: "Foto salva com sucesso", view: self)
    }
    
    private func seePicture(_ photo: UIImage) {
        self.performSegue(withIdentifier: "detailsToScrollPhoto", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsToScrollPhoto" {
            let destinationViewController = segue.destination as! ScrollablePhotoViewController
            destinationViewController.scrollableImage = photoCollectionArray[selectedIndex]
        }
    }
}

//MARK: Collection Data Source
extension DetailsAnnouncementsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: NewReportCollectionViewCell
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newReportCell", for: indexPath as IndexPath) as! NewReportCollectionViewCell
        cell.imagem.image = photoCollectionArray[indexPath.row]
        
        return cell
    }
}
