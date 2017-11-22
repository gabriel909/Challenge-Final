//
//  PopUpViewController.swift
//  Challenge-Final
//
//  Created by Gabriel Oliveira on 5/11/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit
import PopupController

class PopUpViewController: UIViewController, PopupContentViewController {
    var closeHandler: (() -> (Void))?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UITextView!
    @IBOutlet weak var imagem: UIImageView!
    
    var categoryImage: UIImage!
    var titleString: String!
    var desc: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PASSEI AQUIIII")
        
        self.view.layer.cornerRadius = 20
        self.view.layer.masksToBounds = true
        self.imagem.image = categoryImage
        self.imagem.contentMode = .center
//        self.descLabel = UITextView()
        self.titleLabel.text = titleString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    class func instance() -> PopUpViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "PopupViewController") as! PopUpViewController
    }
    
    @IBAction func extiBtnAction(_ sender: UIButton) {
        self.closeHandler!()
    }
    
    public func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
}
