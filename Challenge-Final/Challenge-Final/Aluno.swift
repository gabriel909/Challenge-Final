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
    let escola_id:Int
    //let token: String
    var denuncias:[Denuncia] = []
    var avisos:[Aviso] = []
    
    
    init(parameters: [String:Any]) {
        
        print("bloody parameters: \(parameters)")
        
        self.email = parameters["email"] as! String
        self.name = parameters["nome"] as! String
        self.id = parameters["id"] as! Int
        self.avatar = parameters["avatar"] as! Int
        self.password = parameters["password_digest"] as! String
        self.serie = parameters["serie"] as! String
        self.escola_id = parameters["escola_id"] as! Int
        
        
    }
    
    
    
    func deleteAviso(idAviso: Int) {
        self.avisos = self.avisos.filter({$0.id != idAviso})
    }
    
    init(name: String, password: String, serie: String, email: String, avatar: Int,id: Int,escola_id: Int, token: String) {
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
