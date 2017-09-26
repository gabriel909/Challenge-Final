//
//  Aviso.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

class Aviso {
    let titulo: String
    let descricao: String
    var data: String
    let id: Int
    
    init(titulo: String, descricao: String, data: String, id: Int) {
        self.titulo = titulo
        self.descricao = descricao
        self.data = data
        self.id = id
    }
    
    init(parameters: [String:Any]) {
        self.titulo = parameters["titulo"] as! String
        self.descricao = parameters["descricao"] as! String
        self.data = parameters["created_at"] as! String
        self.id = parameters["id"] as! Int
    }
    
    
    
}
