//
//  Escola.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

class Escola {
    let unidade: String
    let nomeEscola: String
    var id: Int
    
    var json: [String:Any] {
        get {
            let parameters:[String:Any] = ["unidade": self.unidade,"nomeEscola": self.nomeEscola]
            return parameters
        }
    
    }
    
    
    init(parameters: [String:Any]) {
        self.unidade = parameters["unidade"] as! String
        self.nomeEscola = parameters["nome"] as! String
        self.id = parameters["id"] as! Int
    }
    
    init(unidade: String, nomeEscola: String, id: Int) {
        self.nomeEscola = nomeEscola
        self.unidade = unidade
        self.id = id
    }
    
}
