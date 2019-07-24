//
//  Singleton.swift
//  experiments
//
//  Created by Bahlreighn on 7/23/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import Foundation

class Singleton {
    static let sharedInstance = Singleton()
    
    private init() {} // disable init
}

class MultiSingleton {
    static private let tracks = [MultiSingleton](repeating: MultiSingleton(), count: 2)
    
    static var isOdd = false
    
    static var sharedInstance: MultiSingleton {
        isOdd = !isOdd
        let index = isOdd ? 1 : 0
        return tracks[index]
    }
    
    private init() {} // disable init
}
