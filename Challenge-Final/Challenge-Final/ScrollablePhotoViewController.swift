//
//  ScrollablePhotoViewController.swift
//  Challenge-Final
//
//  Created by Gabriel Oliveira on 12/11/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit
import ImageScrollView

class ScrollablePhotoViewController: UIViewController {
    @IBOutlet weak var imageScrollView: ImageScrollView!
    var scrollableImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageScrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.imageScrollView.backgroundColor = .black
        self.imageScrollView.display(image: scrollableImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
}
