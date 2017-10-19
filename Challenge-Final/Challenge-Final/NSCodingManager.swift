//
//  NSCodingManager.swift
//  Challenge-Final
//
//  Created by Gabriel Oliveira on 18/10/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import Foundation

class NSCodingManager: NSObject {
    static let sharedCodingManager = NSCodingManager()
    private let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
    
    private override init() {
        super.init()
    }
    
    func getAny(withPath path: String) -> Any? {
        let archiveURL = documentDirectory?.appendingPathComponent(path)
        return NSKeyedUnarchiver.unarchiveObject(withFile: (archiveURL?.path)!)
    }
    
    func save(_ file: Any, withPath path: String) -> Bool {
        let archiveURL = documentDirectory?.appendingPathComponent(path)
        return NSKeyedArchiver.archiveRootObject(file, toFile: (archiveURL?.path)!)
    }
}
