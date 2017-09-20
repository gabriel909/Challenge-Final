//
//  Aluno.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

class Aluno {
    let name: String
    let email: String
    let serie: String
    let password: String
    let id: Int
    let avatar: Int
    let escola:Escola
    let token: String
    var denuncias:[Denuncia] = []
    var avisos:[Aviso] = []
    
    
    init(parameters: [String:Any]) {
        self.email = parameters["email"] as! String
        self.name = parameters["nome"] as! String
        self.id = parameters["id"] as! Int
        self.token = parameters["token"] as! String
        self.avatar = parameters["avatar"] as! Int
        self.password = parameters["password"] as! String
        self.serie = parameters["serie"] as! String
        self.escola = Escola(parameters: parameters["escola"] as! [String: Any])
        
        
    }
    
    
    
    func deleteAviso(idAviso: Int) {
        self.avisos = self.avisos.filter({$0.id != idAviso})
    }
    
    init(name: String, password: String, serie: String, email: String, avatar: Int,id: Int,escola: Escola, token: String) {
        self.name = name
        self.email = email
        self.password = password
        self.avatar = avatar
        self.serie = serie
        self.id = id
        self.escola = escola
        self.token = token

    }
    
 
}
