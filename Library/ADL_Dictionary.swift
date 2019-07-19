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
    
    fileprivate var buffer = Array<Element?>()
    private(set) public var capacity: Int = 0
    private(set) public var count: Int = 0
    public var isEmpty: Bool {
        return count == 0
    }
    
    init() {
        self.init(minimumCapacity: 0)
    }
    
    init(minimumCapacity: Int) {
        capacity = nextCapacity(after: minimumCapacity)
        buffer = Array<Element?>(repeating: nil, count: capacity)
    }

    private mutating func reallocateArray(minimumCapacity: Int) {
        let newCapacity = nextCapacity(after: minimumCapacity)
        var newArray = Array<Element?>(repeating: nil, count: newCapacity)

        var i: Int
        for e in buffer {
            guard let e = e else { continue }
            i = (e.key.hashValue) % newCapacity
            while newArray[i] != nil {
                i = (i + 1) % newCapacity
            }
            newArray[i] = e
        }

        capacity = newCapacity
        buffer = newArray
    }
    
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
    }
    
    @discardableResult
    public func getValue(forKey key: Key) -> Value? {
        abort()
    }

    @discardableResult
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        abort()
    }
    
    @discardableResult
    public mutating func removeValue(forKey key: Key) -> Value? {
        abort()
    }
}
