//
//  Aviso.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

class Aviso: SuperModel {
    let titulo: String
    let descricao: String
    let data: String
    let id: Int
    
    init(titulo: String, descricao: String, data: String, id: Int) {
        self.titulo = titulo
        self.descricao = descricao
        self.data = data
        self.id = id
        super.init()
    }
    
    func deleteAviso(completion: @escaping (String) -> Void) {
        guard let url = URL(string: self.apiUrl + "/avisos/\(self.id)") else { return }
        self.sharedDAO.sendRequest(url: url, parameters: nil, method: Methods.delete, completion: { (dict) in
            guard let jsonDict = dict as? [String:Any] else { return }
            if jsonDict["error"] != nil {
                completion("error")
            } else {
                completion("ok")
            }
        })
    }
    
    
}
