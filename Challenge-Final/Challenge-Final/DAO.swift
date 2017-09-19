//
//  DAO.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 18/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//


import Foundation

class DAO {
    
    static let sharedDAO = DAO()
    let apiUrl = ""
    
    private init() {
        
    }
    
    public func loginAluno(email: String, password: String,success: @escaping (Aluno) -> Void, failure: @escaping (String) -> Void) {
        let parameters = ["email": email, "password": password]
        guard let url = URL(string: apiUrl + "/alunos/login") else { return }
        sendRequest(url: url, parameters: parameters, method: Methods.post, completion: { (dict) in
            guard let jsonDict = dict as? [String: Any] else { return }
            if jsonDict["error"] == nil {
                
                guard let jsonEscola = jsonDict["escola"] as? [String:Any] else { return }
                
                let newEscola = Escola(unidade: jsonEscola["unidade"] as! String, nomeEscola: jsonEscola["nome"] as! String, id: jsonEscola["id"] as! Int)
                
                
                let newAluno = Aluno(name: jsonDict["name"] as! String, password: jsonDict["password"] as! String, serie: jsonDict["serie"] as! String, email: jsonDict["email"] as! String, avatar: jsonDict["avatar"] as! Int, id: jsonDict["id"] as! Int, escola: newEscola)
                newAluno.token = jsonDict["token"] as! String
                
                success(newAluno)
            } else {
                failure("error")
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
    
}
