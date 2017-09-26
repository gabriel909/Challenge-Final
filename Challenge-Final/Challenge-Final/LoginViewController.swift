//
//  ViewController.swift
//  Challenge-Final
//
//  Created by Gabriel Oliveira on 28/8/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

