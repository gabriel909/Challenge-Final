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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var images:[UIImage] = []
//        var videos:[String] = []
//        images.append(#imageLiteral(resourceName: "teste"))
//
//
//        let documentsFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let videoUrl = documentsFolder.appendingPathComponent("FinalVideo2.mov")
//
//
//        let videoData = try! Data(contentsOf: videoUrl)
//
//        let videoDataString = videoData.base64EncodedString(options: .lineLength64Characters)
//
//
//
//        videos.append(videoDataString)
//        videos.append(videoDataString)
//
//        videos = Base64Enconder.encode(videos: videos)
//
//
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
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
            //MARK: - TODO Login
            self.performSegue(withIdentifier: "login_to_main", sender: self)
            
        }
    }
}
