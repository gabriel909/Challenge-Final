//
//  Aluno.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

class Aluno: SuperModel {
    let name: String
    let email: String
    let serie: String
    let password: String
    let avatar: Int
    
    
    init(name: String, password: String, serie: String, email: String, avatar: Int) {
        self.name = name
        self.email = email
        self.password = password
        self.avatar = avatar
        self.serie = serie
        super.init()
    }
    
    public func enviarDenuncia(denuncia:Denuncia, completion: @escaping (String) -> Void) {
            
    }
    
}
