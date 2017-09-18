//
//  Escola.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

class Escola: SuperModel {
    let unidade: String
    let nomeEscola: String
    
    
    init(unidade: String, nomeEscola: String) {
        self.unidade = unidade
        self.nomeEscola = nomeEscola
        super.init()
    }
    
    
    public func getEscolas() {
        guard  let url  = URL(string: "blablabla") else { return }
        sharedDAO.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict) in
            
        })
    }
    
}
