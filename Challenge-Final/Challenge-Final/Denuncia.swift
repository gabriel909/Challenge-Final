//
//  Denuncia.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/18/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation
import UIKit

class Denuncia: SuperModel {
    let categoria: Categoria
    let descricao: String
    let date: Date
    let status: String
    let images: [UIImage]
    let videos: [UIImage]
    
    init(categoria: Categoria, descricao: String, date: Date, status: String, images: [UIImage], videos: [UIImage]) {
        self.categoria = categoria
        self.descricao = descricao
        self.date = date
        self.status = status
        self.images = images
        self.videos = videos
        super.init()
    }
    
    
}
