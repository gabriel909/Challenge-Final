//
//  Aviso.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

class Aviso {
    let titulo: String
    let descricao: String
    var data: String
    let id: Int
    var images: [String]?
    
    init(titulo: String, descricao: String, data: String, images: [String], id: Int) {
        self.titulo = titulo
        self.descricao = descricao
        self.data = data
        self.images = images
        self.id = id
        
    }
    
    init(parameters: [String : Any], imgsArray: NSArray?) {
        self.titulo = parameters["titulo"] as! String
        self.descricao = parameters["descricao"] as! String
        self.data = parameters["created_at"] as! String
        self.id = parameters["id"] as! Int
        
        var imgUrls: NSArray = []
        
        if imgsArray != nil {
            for img in imgsArray! {
                print("img do kct\(img)")
                let url = Aviso.convertJsonMedia(json: img)
                imgUrls = imgUrls.adding(url) as NSArray
            }
        }
    }
    
    var json: [String:Any] {
        get {
            let parameters: [String:Any] = ["titulo": self.titulo, "descricao": self.descricao, "data": self.data, "image": self.images as Any, "id": self.id]
            
            return parameters
        }
    }
    
    static private func convertJsonMedia(json: Any) -> Any {
        let jsonDict = json as! [String:Any]
        let base64Data = jsonDict["image_data"] as! [String:Any]
        return base64Data["url"]
    }
}
