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
    
    private init() {
        
    }
    
    public func createAluno(nome: String) {
        
    
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
                    completion(json["data"])
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
        
    }
    
}
