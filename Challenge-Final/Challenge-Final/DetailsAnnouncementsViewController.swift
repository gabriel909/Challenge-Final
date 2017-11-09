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
    
    fileprivate var collectionView: UICollectionView!
    fileprivate var photoCollectionArray: [UIImage]! = []
    
    var aviso: Aviso!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadLabels()
        self.collectionSetup()
        
        title = aviso.titulo
        
        if !photoCollectionArray.isEmpty {
            attachmentLabel.isHidden = true
        }
    }
    
    private func loadLabels() {
        descTextView.text = aviso.descricao
        dataLabel.text = aviso.data.getFormattedDate()
        print(aviso.data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func collectionSetup() {
        let collectionViewRect = CGRect(x: 0, y: height / 2.31, width: width, height: height / 5.16)
        let collectionViewCellNib = UINib(nibName: "NewReportCollectionViewCell", bundle: nil)
        
        self.photoCollectionArray = self.getImageArray()
        
        self.collectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: createLayout())
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: "newReportCell")
        self.collectionView.clipsToBounds = true
        
        self.view.addSubview(collectionView)
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
    
    private func getImageArray() -> [UIImage] {
        var array: [UIImage] = []
        print("OLHA EU AQUI DE NOVO")
        
        if aviso.images != nil {
            print("XAXANDO")
            for urlString in aviso.images! {
                let url = URL(string: "http://139.82.24.231:3000/\(urlString)")
                print("URL CARALHO \(url)")
                let data = try? Data(contentsOf: url!)
                let image: UIImage = UIImage(data: data!)!
                
                array.append(image)
            }
        }
        
        return array
    }
}

extension DetailsAnnouncementsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openAlert(indexPath.row)
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
        
    }
}

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
