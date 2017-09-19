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
    var id: Int
    
    
    init(unidade: String, nomeEscola: String, id: Int) {
        self.nomeEscola = nomeEscola
        self.unidade = unidade
        self.id = id
    }
    
    init(unidade: String, nomeEscola: String) {
        self.unidade = unidade
        self.nomeEscola = nomeEscola
        self.id = -1
        
        super.init()
        
        guard let url = URL(string: self.apiUrl + "/escolas/select") else { return }
        let parameters = ["escola": self.nomeEscola, "unidade": self.unidade]
        sharedDAO.sendRequest(url: url, parameters: parameters, method: Methods.get, completion: { (dict) in
            guard let jsonDict = dict as? [String: Any] else { return }
            
            if jsonDict["error"] != nil {
                print("error")
            }
            self.id = jsonDict["id"] as! Int
            
        })
        
        
    }
    
    
    
    public func getEscolas(completion: @escaping ([Escola]) -> Void) {
        guard let url  = URL(string: self.apiUrl + "/escolas") else { return }
        sharedDAO.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict) in
            
            var arrayEscola: [Escola] = []
            
            guard let jsonDictArray = dict as? NSArray else { return }
            
            for escola in jsonDictArray {
                guard let jsonEscola = escola as? [String: Any] else { return }
                
                let newEscola = Escola(unidade: jsonEscola["unidade"] as! String, nomeEscola: jsonEscola["nomeEscola"] as! String, id: jsonEscola["id"] as! Int)
                arrayEscola.append(newEscola)
            }
            
            completion(arrayEscola)
            
        })
    }
    

    
}
