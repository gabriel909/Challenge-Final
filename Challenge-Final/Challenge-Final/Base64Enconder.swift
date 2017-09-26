//
//  base64Converter.swift
//  Challenge-Final
//
//  Created by Victor Nogueira on 9/25/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation
import UIKit

class Base64Enconder {
    static private func encode(img: UIImage) -> String {
        let imgData = UIImagePNGRepresentation(img)!
        let imgDataBase64 = imgData.base64EncodedString(options: .lineLength64Characters)
        return "data:image/png;base64," + imgDataBase64
    }
    
    static private func encode(video: String) -> String {
        return "data:video/quicktime;base64," + video
    }
    
    static public func encode(videos: [String]) -> [String] {
        var result: [String] = []
        for video in videos {
            result.append(encode(video: video))
        }
        return result
    }
    
    static public func encode(imgs: [UIImage]) -> [String] {
        var imgsDataBase64: [String] = []
        for img in imgs {
            imgsDataBase64.append(encode(img: img))
        }
        return imgsDataBase64
    }
}
