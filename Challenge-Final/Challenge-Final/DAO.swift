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
    let apiUrl = "http://localhost:3000"
    var aluno: Aluno? = nil
    
    private init() {
        
    }
    
    /* Aluno */
    public func createAluno(name: String, password: String, serie: String, email: String,avatar: Int, escola: Escola, completion: @escaping (Aluno) -> Void) {
        
        let parameters:[String: Any] = ["nome": name, "password": password, "serie": serie, "email": email,"avatar": avatar]
        
        guard let url = URL(string: self.apiUrl + "/escolas/\(escola.id)/alunos/signup") else { return }
        self.sendRequest(url: url, parameters: parameters, method: Methods.post, completion: { (dict,abc,def) in
            
            
            guard var jsonDict = dict as? [String:Any] else { return }
            
            jsonDict["avatar"] = avatar
            
            //newParams["token"] = jsonDict["Authorization"] as! String
            //newParams["id"] = jsonDict["id"] as! Int
            
            self.aluno = Aluno(parameters: jsonDict)
            
            completion(self.aluno!)
            
        })
    
    }
    
    public func loginAluno(email: String, password: String,success: @escaping (Aluno) -> Void, failure: @escaping (String) -> Void) {
        let parameters = ["email": email, "password": password]
        guard let url = URL(string: apiUrl + "/alunos/login") else { return }
        sendRequest(url: url, parameters: parameters, method: Methods.post, completion: { (dict,abc,def) in
            guard let jsonDict = dict as? [String: Any] else { return }
            if jsonDict["error"] == nil {
                
                self.aluno = Aluno(parameters: jsonDict)
                
                success(self.aluno!)
            } else {
                failure("error")
                self.aluno = nil
                
            }
        })
    }
    
    /* Avisos */
    public func getAvisos(idAluno: Int,completion: @escaping (Aluno) -> Void) {
        guard let url = URL(string: self.apiUrl + "/alunos/\(idAluno)/avisos") else { return }
        
        self.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict,abc,def) in
            
            
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
    
    func deleteAviso(idAviso: Int, completion: @escaping (String) -> Void) {
        guard let url = URL(string: self.apiUrl + "/alunos/\(aluno!.id)/avisos/\(idAviso)") else { return }
        self.sendRequest(url: url, parameters: nil, method: Methods.delete, completion: {  (dict,abc,def) in
            guard let jsonDict = dict as? [String:Any] else { return }
            if jsonDict["error"] != nil {
                completion("error")
            } else {
                self.aluno!.deleteAviso(idAviso: idAviso)
                completion("ok")
            }
        })
    }
    
    /* Denuncias */
    public func getDenuncias(completion: @escaping (Aluno) -> Void) {
        guard let url = URL(string: self.apiUrl + "/alunos/\(aluno!.id)/denuncias") else { return }
        self.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict,imgsDict,videosDict) in
            
            
            guard let jsonDictArray = dict as? NSArray else { return }
            
            var arrayDenuncias: [Denuncia] = []
            
            for denuncia in jsonDictArray {
                
                guard let jsonDenuncia = denuncia as? [String: Any] else { return }
                let newDenuncia = Denuncia(parameters: jsonDenuncia, imgsArray: nil, videosArray: nil)
    
                arrayDenuncias.append(newDenuncia)
                
            }
            
            self.aluno!.denuncias = arrayDenuncias
            
            completion(self.aluno!)
            
        })
        
    }
    
    public func sendDenuncia(denuncia: Denuncia, idAluno: Int, idEscola: Int, completion: @escaping (Denuncia) -> Void) {
        
        guard let url = URL(string: self.apiUrl + "/escolas/\(idEscola)/alunos/\(idAluno)/denuncias") else { return }
        
        
        let params = denuncia.json
        //print("params: \(params)")
        //params["Authorization"] = aluno!.token
        
        self.sendRequest(url: url, parameters: params, method: Methods.post, completion: { (dict,imgsDict,videosDict) in
            
            print("dict fuck: \(dict)")
            
            
            guard let jsonDict = dict as? [String:Any] else { return }
            guard let imgsArray = imgsDict as? NSArray else { return }
            guard let videosArray = videosDict as? NSArray else { return }
            
            
            completion(Denuncia(parameters: jsonDict, imgsArray: imgsArray, videosArray: videosArray))
            
            
        })
        
    }
    
    
    /* Escola */
    public func getEscolas(completion: @escaping ([Escola]) -> Void) {
        guard let url  = URL(string: self.apiUrl + "/escolas") else { return }
        print("method: \(Methods.get)")
        self.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict,imgsDict,nil) in
            
            var arrayEscola: [Escola] = []
            
            guard let jsonDictArray = dict as? NSArray else { print("scheisse"); return }
            
            for escola in jsonDictArray {
                guard let jsonEscola = escola as? [String: Any] else { return }
                
                let newEscola = Escola(parameters: jsonEscola)
                arrayEscola.append(newEscola)
            }
            
            completion(arrayEscola)
            
        })
    }
    
    /* Request Sender */
    public func sendRequest(url: URL, parameters: [String:Any]? ,method: Methods,completion: @escaping (Any,Any?,Any?) -> Void) {
        let session = URLSession.shared
        print("url \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if parameters != nil {
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters as Any, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("error: \(error?.localizedDescription)")
                return
            }
            
            guard let data = data else {
                
                return
            }
            
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    
                    
                    completion(json["data"] as Any,json["img"] as Any?,json["video"] as Any?)
                    
                } else {
                    print("damn")
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
        
    }
    
}
