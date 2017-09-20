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
    let status: String
    let images: [UIImage]
    let videos: [URL]
    
    init(categoria: Categoria, descricao: String, date: String, status: String, images: [UIImage], videos: [URL]) {
        self.categoria = categoria
        self.descricao = descricao
        self.date = date
        self.status = status
        self.images = images
        self.videos = videos
    }
    
    init(parameters: [String:Any]) {
        var denunciaImage:[UIImage] = []
        var denunciaVideo:[URL] = []
        let jsonDenuncia = parameters
        
        let jsonDenunciaImages = jsonDenuncia["images"] as! NSArray
        let jsonDenunciaVideos = jsonDenuncia["videos"] as! NSArray
        
        for video in jsonDenunciaVideos {
            
            let jsonVideo = video as! [String:Any]
            
             let videoString = jsonVideo["URL"] as! String
            
            let videoURL = URL(string: videoString)
            
            denunciaVideo.append(videoURL!)
            
        }
        
        for image in jsonDenunciaImages {
            
            let jsonVideo = image as! [String:Any]
            
            let dataDecoded : Data = Data(base64Encoded: jsonVideo["base64Str"] as! String, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            denunciaImage.append(decodedimage!)
            
        }
        
        self.categoria = Categoria(rawValue: jsonDenuncia["categoria"] as! String)!
        self.date = jsonDenuncia["created_at"] as! String
        self.descricao = jsonDenuncia["descricao"] as! String
        self.status = jsonDenuncia["status"] as! String
        self.images = denunciaImage
        self.videos = denunciaVideo
        
    }
    
    var json: [String:Any] {
        
        
        get {
        
        var imagesBase64: [String:Any] = [:]
        var videosBase64: [String:Any] = [:]
        
        var counter = 1 //this is needed to provide a key for the image and video json
        
        
        for image in self.images {
            let base64ImageData = UIImagePNGRepresentation(image)! as Data
            
            let strBase64 = base64ImageData.base64EncodedString(options: .lineLength64Characters)
            
            let key = "image" + String(counter)
            
            imagesBase64[key] = strBase64
            
            counter += 1
            
        }
        
        counter = 1
        
        for video in self.videos {
            
            var base64VideoData: Data = Data()
            base64VideoData = try! Data(contentsOf: video)
            
            
            let strBase64 = base64VideoData.base64EncodedString(options: .lineLength64Characters)
            
            let key = "video" + String(counter)
            
            videosBase64[key] = strBase64
            
            counter += 1
            
        }
        
        
        
        let parameters: [String:Any] = ["categoria": self.categoria, "descricao": self.descricao, "date": self.date, "status": self.status,"videos": videosBase64, "images": imagesBase64]
        
        return parameters
        }
    }
    
    
}
