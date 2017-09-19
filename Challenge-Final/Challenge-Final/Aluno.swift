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
    var id: Int
    let avatar: Int
    let escola:Escola
    
    
    init(name: String, password: String, serie: String, email: String,avatar: Int, escola: Escola) {
       
        let parameters = ["name": name, "password": password, "serie": serie, "email": email]
        self.email = email
        self.password = password
        self.serie = serie
        self.name = name
        self.id = -1
        self.avatar = avatar
        self.escola = escola
        
        super.init()
        
        guard let url = URL(string: self.apiUrl + "/alunos/signup") else { return }
        self.sharedDAO.sendRequest(url: url, parameters: parameters, method: Methods.post, completion: { (dict) in
            
            guard let jsonDict = dict as? [String:Any] else { return }
            
            self.token = jsonDict["Authorization"] as! String
            self.id = jsonDict["id"] as! Int
        })
        
        
    }
    
    init(name: String, password: String, serie: String, email: String, avatar: Int,id: Int,escola: Escola) {
        self.name = name
        self.email = email
        self.password = password
        self.avatar = avatar
        self.serie = serie
        self.id = id
        self.escola = escola
        
        super.init()
        
    }
    
    
    
    public func sendDenuncia(denuncia:Denuncia, completion: @escaping (String) -> Void) {
        /* work on it when you discover how to upload videos to ios and how the video will be loaded in memory */
        
        guard let url = URL(string: self.apiUrl + "/alunos/\(self.id)/denuncias") else { return }
        
        
        let params = denuncia.getDenunciaAsJson()
        
        self.sharedDAO.sendRequest(url: url, parameters: params, method: Methods.post, completion: { (dict) in
            
            guard let jsonDict = dict as? [String:Any] else { return }
            
            if (jsonDict["error"] as! String) != "none" {
                    completion("error")
            } else {
                completion("success")
            }
            
        
        })
        
    }
    
    public func getDenuncias(completion: @escaping ([Denuncia]) -> Void) {
        guard let url = URL(string: self.apiUrl + "/alunos/\(self.id)/denuncias") else { return }
        self.sharedDAO.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict) in
            
            
            guard let jsonDictArray = dict as? NSArray else { return }
            
            var arrayDenuncias: [Denuncia] = []
            
            for denuncia in jsonDictArray {
                
                guard let jsonDenuncia = denuncia as? [String: Any] else { return }
                
                /*
                 create denuncia
                 append denuncia to array
                 */
            }
            completion(arrayDenuncias)
            
        })
        
    }
    
    public func getAvisos(completion: @escaping ([Aviso]) -> Void) {
        guard let url = URL(string: self.apiUrl + "/alunos/\(self.id)/avisos") else { return }
        
        self.sharedDAO.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict) in
            
            
            guard let jsonDictArray = dict as? NSArray else { return }
            
            var arrayAviso: [Aviso] = []
            
            for aviso in jsonDictArray {
                
                guard let jsonAviso = aviso as? [String: Any] else { return }
                
                
                let newAviso = Aviso(titulo: jsonAviso["titulo"] as! String, descricao: jsonAviso["descricao"] as! String, data: jsonAviso["CreatedAt"] as! String)
                
                arrayAviso.append(newAviso)
            }
            
        
        })
        
    }
    
    
}



