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
    let series: [Serie]
    let data: Date
    
    init(titulo: String, descricao: String, series: [Serie], data: Date) {
        self.titulo = titulo
        self.descricao = descricao
        self.series = series
        self.data = data
        super.init()
    }
    
    public func getAvisos(completion: @escaping (Aviso) -> Void) {
        guard let url = URL(string: self.apiUrl + "/avisos") else { return }
        self.sharedDAO.sendRequest(url: url, parameters: nil, method: Methods.get, completion: { (dict) in
            
            
        }
        )
    }
    
}
