//
//  Aluno.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

class Aluno: NSObject, NSCoding {
    var name: String
    var email: String
    var serie: String
    var password: String
    var id: Int?
    var avatar: Int?
    var escola_id: Int
    let token: String?
    var denuncias:[Denuncia] = []
    var avisos:[Aviso] = []
    
    public required init?(coder aDecoder: NSCoder) {
        if let name = aDecoder.decodeObject(forKey: "name") as? String {
            self.name = name
            
        } else {
            self.name = ""
            
        }
        
        if let email = aDecoder.decodeObject(forKey: "email") as? String {
            self.email = email
            
        } else {
            self.email = ""
            
        }
        
        if let serie = aDecoder.decodeObject(forKey: "serie") as? String {
            self.serie = serie
            
        } else {
            self.serie = ""
            
        }
        
        if let password = aDecoder.decodeObject(forKey: "password") as? String {
            self.password = password
            
        } else {
            self.password = ""
            
        }
        
        if let id = aDecoder.decodeObject(forKey: "id") as? Int {
            self.id = id
            
        } else {
            self.id = -1
            
        }
        
        if let avatar = aDecoder.decodeObject(forKey: "avatar") as? Int {
            self.avatar = avatar
            
        } else {
            self.avatar = -1
            
        }
        
        if let escola_id = aDecoder.decodeInteger(forKey: "escola_id") as? Int {
            self.escola_id = escola_id
            
        } else {
            self.escola_id = -1
            
        }
        
        if let token = aDecoder.decodeObject(forKey: "token") as? String {
            self.token = token
            
        } else {
            self.token = ""
            
        }
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.serie, forKey: "serie")
        aCoder.encode(self.password, forKey: "password")
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.avatar, forKey: "avatar")
        aCoder.encode(self.escola_id, forKey: "escola_id")
        aCoder.encode(self.token, forKey: "token")
    }
    
    init(parameters: [String : Any]) {
        
        print("bloody parameters: \(parameters)")
        let aluno = parameters["aluno"]! as! [String : Any]
        
        self.email = aluno["email"] as! String
        self.name = aluno["nome"] as! String
        self.id = (aluno["id"] as! Int)
//        self.avatar = parameters["avatar"] as! Int
        self.password = aluno["password_digest"] as! String
        self.serie = aluno["serie"] as! String
        self.escola_id = aluno["escola_id"] as! Int
        
        if parameters["auth_token"] != nil {
            self.token = (parameters["auth_token"] as! String)
            
        } else {
            self.token = nil
            
        }
    }
    
    override init() {
        self.name = ""
        self.email = ""
        self.serie = ""
        self.password = ""
        self.avatar = 0
        self.escola_id = 0
        self.token = nil
    }
    
    func deleteAviso(idAviso: Int) {
        self.avisos = self.avisos.filter({$0.id != idAviso})
    }
    
    init(name: String, password: String, serie: String, email: String, avatar: Int, id: Int, escola_id: Int, token: String) {
        self.name = name
        self.email = email
        self.password = password
        self.avatar = avatar
        self.serie = serie
        self.id = id
        self.escola_id = escola_id
        self.token = token

    }
}
