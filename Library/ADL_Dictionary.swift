//
//  ADL_Dictionary.swift
//  experiments
//
//  Created by Bahlreighn on 7/16/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import Foundation

public struct ADL_Dictionary<Key, Value> where Key: Hashable {
    
    public typealias Element = (key: Key, value: Value)
    
    fileprivate var buffer: Array<Value>
    public var capacity: Int {
        return buffer.capacity
    }
    private(set) public var count: Int = 0
    public var isEmpty: Bool {
        return count == 0
    }
    
    init() {
        buffer = Array<Value>()
    }
    
//    init(minimumCapacity: Int) {
//        
//    }

//    private mutating func reallocateArray(minimumCapacity: Int) {
//        let newCapacity = nextCapacity(after: minimumCapacity)
//        let newArray = Array<Value>()
//        newArray.reserveCapacity(newCapacity)
//
//        for e in buffer {
//
//        }
//
//        capacity = newCapacity
//        buffer = newArray
//    }
    
    private func nextCapacity(after n: Int) -> Int {
        return next3x2byn(after: n)
    }
    
    private func next3x2byn(after n: Int) -> Int {
        guard n > 0 else { return 1 }
        guard n > 1 else { return 3 }
        
        let normalized = Float(n) / 3
        let l2 = log2(normalized)
        let exponent = floor(l2) + 1
        
        return Int(3 * pow(2.0, exponent))
    }}
