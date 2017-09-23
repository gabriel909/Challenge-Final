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
        let den = Denuncia(categoria: Categoria.Colegas, descricao: "sla", date: "fdafdsa", status: Status.andamento, images: nil, videos: nil)
        DAO.sharedDAO.sendDenuncia(denuncia: den, idAluno: 11,idEscola: 1 ,completion: { (den) in
            print("den category: \(den.descricao)")
            
        })
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

