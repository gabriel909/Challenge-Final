//
//  Denuncia.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation
import UIKit

class Denuncia {
    let categoria: Categoria
    let descricao: String
    let date: String
    let status: Status
    let images: [String]?
    let videos: [String]?
    
    
    init(categoria: Categoria, descricao: String, date: String, status: Status, images: [String]?, videos: [String]?) {
        self.categoria = categoria
        self.descricao = descricao
        self.date = date
        self.status = status
        self.images = images
        self.videos = videos
    }
    
    init(parameters: [String:Any], imgsArray: NSArray?, videosArray: NSArray?) {
        let jsonDenuncia = parameters
        
        var imgUrls: NSArray = []
        var videoUrls: NSArray = []
        
        
        print("json jesus")
        
        if imgsArray != nil {
            
            for img in imgsArray! {
                let url = Denuncia.convertJsonMedia(json: img)
                imgUrls = imgUrls.adding(url) as NSArray
            }
        }
        
        if videosArray != nil {
            
            for video in videosArray! {
                let url = Denuncia.convertJsonMedia(json: video)
                videoUrls = videoUrls.adding(url) as NSArray
            }
            
        }
        
        
        self.categoria = Categoria(rawValue: jsonDenuncia["categoria"] as! String)!
//        self.date = jsonDenuncia["created_at"] as! String
        //MARK: - TODO Add date column on rails
        self.date = ""
        self.descricao = jsonDenuncia["descricao"] as! String
        let status = jsonDenuncia["status"] as! String
        
        switch status {
            case "Em Andamento":
                self.status = Status.andamento
            
            case "Resolvido":
                self.status = Status.resolvido
            
            default:
                self.status = Status.nao_resolvido
        }
        
        self.images = imgUrls as? [String]
        self.videos = videoUrls as? [String]
        
        for image in self.images! {
            print("url: \(image)")
        }
        
        for video in self.videos! {
            print("videoUrl: \(video)")
        }
        
    }
    
    var json: [String:Any] {
        
        get {
            
            let parameters: [String:Any] = ["categoria": self.categoria.rawValue, "descricao": self.descricao, "status": self.status.rawValue,"video": self.videos, "image": self.images as Any]
            
            return parameters
        }
    }
    
    static private func convertJsonMedia(json: Any) -> Any {
        let jsonDict = json as! [String:Any]
        let base64Data = jsonDict["image_data"] as! [String:Any]
        return base64Data["url"]
    }
    
}
