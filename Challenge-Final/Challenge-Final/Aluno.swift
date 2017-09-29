//
//  Aluno.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

class Aluno {
    var name: String
    var email: String
    var serie: String
    var password: String
    var id: Int?
    var avatar: Int?
    var escola_id: Int
    //let token: String
    var denuncias:[Denuncia] = []
    var avisos:[Aviso] = []
    
    
    init(parameters: [String:Any]) {
        
        print("bloody parameters: \(parameters)")
        
        self.email = parameters["email"] as! String
        self.name = parameters["nome"] as! String
        self.id = parameters["id"] as! Int
//        self.avatar = parameters["avatar"] as! Int
        self.password = parameters["password_digest"] as! String
        self.serie = parameters["serie"] as! String
        self.escola_id = parameters["escola_id"] as! Int
        
        
    }
    
    init() {
        self.name = ""
        self.email = ""
        self.serie = ""
        self.password = ""
        self.avatar = 0
        self.escola_id = 0
    }
    
    func deleteAviso(idAviso: Int) {
        self.avisos = self.avisos.filter({$0.id != idAviso})
    }
    
    init(name: String, password: String, serie: String, email: String, avatar: Int,id: Int, escola_id: Int, token: String) {
        self.name = name
        self.email = email
        self.password = password
        self.avatar = avatar
        self.serie = serie
        self.id = id
        self.escola_id = escola_id
//        self.token = token

    }
}
