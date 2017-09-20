//
//  DAO.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 18/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//


import Foundation
import UIKit


class DAO {
    
    static let sharedDAO = DAO()
    let apiUrl = ""
    var aluno: Aluno? = nil
    
    private init() {
        
    }
    
    public func createAluno(name: String, password: String, serie: String, email: String,avatar: Int, escola: Escola, completion: @escaping (Aluno) -> Void) {
        
        let parameters:[String: Any] = ["name": name, "password": password, "serie": serie, "email": email,"escola": escola.json]
        
        guard let url = URL(string: self.apiUrl + "/alunos/signup") else { return }
        self.sendRequest(url: url, parameters: parameters, method: Methods.post, completion: { (dict) in
            
            var newParams = parameters
            
            guard let jsonDict = dict as? [String:Any] else { return }

            
            newParams["token"] = jsonDict["Authorization"] as! String
            newParams["id"] = jsonDict["id"] as! Int
            
            let newAluno = Aluno(parameters: newParams)
            
            completion(newAluno)
            
        })
    
    }
    
    public func getAvisos(idAluno: Int,completion: @escaping (Aluno) -> Void) {
        guard let url = URL(string: self.apiUrl + "/alunos/\(idAluno)/avisos") else { return }
        
        self.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict) in
            
            
            guard let jsonDictArray = dict as? NSArray else { return }
            
            var arrayAviso: [Aviso] = []
            
            for aviso in jsonDictArray {
                
                guard let jsonAviso = aviso as? [String: Any] else { return }
                
                
                let newAviso = Aviso(parameters: jsonAviso)
                
                arrayAviso.append(newAviso)
            }
            
            self.aluno!.avisos = arrayAviso
            
            completion(self.aluno!)
        })
        
    }
    
    public func getDenuncias(idAluno: Int,completion: @escaping (Aluno) -> Void) {
        guard let url = URL(string: self.apiUrl + "/alunos/\(idAluno)/denuncias") else { return }
        self.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict) in
            
            
            guard let jsonDictArray = dict as? NSArray else { return }
            
            var arrayDenuncias: [Denuncia] = []
            
            for denuncia in jsonDictArray {
                
                guard let jsonDenuncia = denuncia as? [String: Any] else { return }
                let newDenuncia = Denuncia(parameters: jsonDenuncia)
    
                arrayDenuncias.append(newDenuncia)
                
            }
            
            self.aluno!.denuncias = arrayDenuncias
            
            completion(self.aluno!)
            
        })
        
    }
    
    public func sendDenuncia(denuncia:Denuncia,idAluno: Int,completion: @escaping (String) -> Void) {
        
        guard let url = URL(string: self.apiUrl + "/alunos/\(idAluno)/denuncias") else { return }
        
        
        let params = denuncia.json
        
        self.sendRequest(url: url, parameters: params, method: Methods.post, completion: { (dict) in
            
            guard let jsonDict = dict as? [String:Any] else { return }
            
            if (jsonDict["error"] as! String) != "none" {
                completion("error")
            } else {
                completion("success")
            }
            
            
        })
        
    }
    
    func deleteAviso(idAviso: Int, completion: @escaping (String) -> Void) {
        guard let url = URL(string: self.apiUrl + "/alunos/\(aluno!.id)/avisos/\(idAviso)") else { return }
        self.sendRequest(url: url, parameters: nil, method: Methods.delete, completion: { (dict) in
            guard let jsonDict = dict as? [String:Any] else { return }
            if jsonDict["error"] != nil {
                completion("error")
            } else {
                self.aluno!.deleteAviso(idAviso: idAviso)
                completion("ok")
            }
        })
    }

    
    
    public func loginAluno(email: String, password: String,success: @escaping (Aluno) -> Void, failure: @escaping (String) -> Void) {
        let parameters = ["email": email, "password": password]
        guard let url = URL(string: apiUrl + "/alunos/login") else { return }
        sendRequest(url: url, parameters: parameters, method: Methods.post, completion: { (dict) in
            guard let jsonDict = dict as? [String: Any] else { return }
            if jsonDict["error"] == nil {
                
                let newAluno = Aluno(parameters: jsonDict)
                
                success(newAluno)
            } else {
                failure("error")
                self.aluno = nil
                
            }
        })
    }
    
    public func sendRequest(url: URL, parameters: [String:Any]? ,method: Methods,completion: @escaping (Any) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters as Any, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    completion(json["data"] as Any)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
        
    }
    
    public func getEscolas(completion: @escaping ([Escola]) -> Void) {
        guard let url  = URL(string: self.apiUrl + "/escolas") else { return }
        self.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict) in
            
            var arrayEscola: [Escola] = []
            
            guard let jsonDictArray = dict as? NSArray else { return }
            
            for escola in jsonDictArray {
                guard let jsonEscola = escola as? [String: Any] else { return }
                
                let newEscola = Escola(parameters: jsonEscola)
                arrayEscola.append(newEscola)
            }
            
            completion(arrayEscola)
            
        })
    }
    
}
