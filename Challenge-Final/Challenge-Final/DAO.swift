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
    let apiUrl = "http://139.82.24.231:3000"
    var aluno: Aluno? = nil
    var announcementsCount: Int = 0
    
    private let archiver = NSCodingManager.sharedCodingManager
    
    private init() { }
    
    /* Aluno */
    func set(aluno: Aluno) {
        self.aluno = aluno
        print(archiver.save(aluno, withPath: "aluno"))
        let _ = archiver.save(announcementsCount, withPath: "count")
    }
    
    func getLoggedAluno() -> Aluno? {
        aluno = archiver.getAny(withPath: "aluno") as? Aluno
        
        return aluno
    }
    
    public func createAluno(name: String, password: String, serie: String, email: String,avatar: Int, escola: Escola, completion: @escaping (Aluno) -> Void) {
        
        let parameters:[String: Any] = ["nome": name, "password": password, "serie": serie, "email": email]
        
        guard let url = URL(string: self.apiUrl + "/escolas/\(escola.id)/alunos/signup") else { return }
        self.sendRequest(url: url, parameters: parameters, method: Methods.post, completion: { (dict, abc, def) in
            guard var jsonDict = dict as? [String:Any] else { return }
            
//            jsonDict["avatar"] = avatar
            
            //newParams["token"] = jsonDict["Authorization"] as! String
            //newParams["id"] = jsonDict["id"] as! Int
            
            self.aluno = Aluno(parameters: jsonDict)
            
            completion(self.aluno!)
            
        })
    }
    
    public func create(aluno: Aluno, escola_id: Int, completion: @escaping (Aluno) -> Void) {
        
        let parameters:[String: Any] = ["nome": aluno.name, "password": aluno.password, "serie": aluno.serie, "email": aluno.email/*, "avatar": aluno.avatar*/]
        
        guard let url = URL(string: self.apiUrl + "/escolas/\(escola_id)/alunos/signup") else { return }
        self.sendRequest(url: url, parameters: parameters, method: Methods.post, completion: { (dict, abc, def) in
            guard var jsonDict = dict as? [String:Any] else { return }
            
//            jsonDict["avatar"] = aluno.avatar
            
            //newParams["token"] = jsonDict["Authorization"] as! String
            //newParams["id"] = jsonDict["id"] as! Int
            
            self.aluno = Aluno(parameters: jsonDict)
            
            completion(self.aluno!)
            
        })
    }
    
    public func loginAluno(email: String, password: String, completion: @escaping (Aluno?, String?) -> Void) {
        var parameters = ["email": email, "password": password]
        guard let url = URL(string: apiUrl + "/alunos/login") else { return }
        
        parameters["header"] = aluno?.token
        
        sendRequest(url: url, parameters: parameters, method: Methods.post, completion: { (dict, _, _) in
            guard let jsonDict = dict as? [String : Any] else { return }
            
            if jsonDict["message"] == nil {
                self.aluno = Aluno(parameters: jsonDict)
//                self.announcementsCount = jsonDict["count"] as! Int
                completion(self.aluno!, nil)
                
            } else {
                completion(nil, "error")
                self.aluno = nil
                
            }
        })
    }
    
    /* Avisos */
    public func getAvisos(forAluno aluno: Aluno, completion: @escaping ([Aviso]) -> Void) {
        guard let url = URL(string: self.apiUrl + "/escolas/\(aluno.escola_id)/alunos/\(aluno.id!)/avisos") else { return }
        
        let parameters: [String : Any] = ["header" : aluno.token as Any]
        
        self.sendRequest(url: url, parameters: parameters, method: Methods.get, completion: { (dict, abc, def) in
            
            guard let jsonDictArray = dict as? NSArray else { return }
            
            var arrayAviso: [Aviso] = []
            
            for aviso in jsonDictArray {
                
                guard let jsonAviso = aviso as? [String : Any] else { return }
                
                var newAviso: Aviso? = nil
                
                if let imgArray = jsonAviso["image"] as? NSArray {
                    print("IMAGE")
                    newAviso = Aviso(parameters: jsonAviso["aviso"] as! [String : Any], imgsArray: imgArray)
                    
                } else {
                    newAviso = Aviso(parameters: jsonAviso, imgsArray: nil)
                    
                }
                
                arrayAviso.append(newAviso!)
            }
            
            self.aluno!.avisos = arrayAviso
            
            completion(arrayAviso)
        })
        
    }
    
    func deleteAviso(idAviso: Int, completion: @escaping (String) -> Void) {
        guard let url = URL(string: self.apiUrl + "/alunos/\(aluno!.id!)/avisos/\(idAviso)") else { return }
        
        let parameters: [String : Any] = ["header" : aluno?.token as Any]
        
        self.sendRequest(url: url, parameters: parameters, method: Methods.delete, completion: {  (dict, abc, def) in
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
    public func getDenuncias(forAluno aluno: Aluno, completion: @escaping ([Denuncia]) -> Void) {
        guard let url = URL(string: self.apiUrl + "/escolas/\(aluno.escola_id)/alunos/\(aluno.id!)/reports") else { return }
        
        let parameters: [String : Any] = ["header" : aluno.token as Any]
        
        self.sendRequest(url: url, parameters: parameters, method: Methods.get, completion: { (dict, imgsDict, videosDict) in
            guard let jsonDictArray = dict as? NSArray else { return }
            var arrayDenuncias: [Denuncia] = []
            
            for denuncia in jsonDictArray {
                guard let jsonDenuncia = denuncia as? [String: Any] else { return }
                var newDenuncia: Denuncia? = nil
                
                if let imgArray = jsonDenuncia["image"] as? NSArray {
                    newDenuncia = Denuncia(parameters: jsonDenuncia["report"] as! [String : Any], imgsArray: imgArray, videosArray: nil)
                    
                } else {
                    newDenuncia = Denuncia(parameters: jsonDenuncia, imgsArray: nil, videosArray: nil)
                    
                }
    
                arrayDenuncias.append(newDenuncia!)
            }
            
            self.aluno!.denuncias = arrayDenuncias
            completion(arrayDenuncias)
        })
    }
    
    public func sendDenuncia(denuncia: Denuncia, idAluno: Int, idEscola: Int, completion: @escaping (Denuncia) -> Void) {
        guard let url = URL(string: self.apiUrl + "/escolas/\(idEscola)/alunos/\(idAluno)/denuncias") else { return }
        
        var params = denuncia.json
        params["header"] = aluno?.token
        
        self.sendRequest(url: url, parameters: params, method: Methods.post, completion: { (dict, imgsDict, videosDict) in
            guard let jsonDict = dict as? [String : Any] else { return }
            guard let imgsArray = imgsDict as? NSArray else { return }
            guard let videosArray = videosDict as? NSArray else { return }
            
            completion(Denuncia(parameters: jsonDict, imgsArray: imgsArray, videosArray: videosArray))
        })
    }
    
    /* Escola */
    public func getEscolas(completion: @escaping ([Escola]) -> Void) {
        guard let url  = URL(string: self.apiUrl + "/escolas") else { return }
        print("method: \(Methods.get)")
        
//        let parameters: [String : Any] = ["header" : aluno?.token as Any]
//
//        print("ALUNO TOKEN \(aluno?.token)")
        
        self.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict, imgsDict, nil) in
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
    public func sendRequest(url: URL, parameters: [String : Any]?, method: Methods, completion: @escaping (Any, Any?, Any?) -> Void) {
        let session = URLSession.shared
        print("url \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if parameters != nil {
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            if parameters!["header"] != nil {
                request.setValue((parameters!["header"] as! String), forHTTPHeaderField: "Authorization")
            }
            
            if method == Methods.post {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters as Any, options: .prettyPrinted)
                    
                } catch let error {
                    print(error.localizedDescription)
                    
                }
            }
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("error: \(error?.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    completion(json["data"] as Any, json["img"] as Any?, json["video"] as Any?)
                    
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
