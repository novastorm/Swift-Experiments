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
    
    fileprivate var buffer: Array<Element?>
    private(set) public var capacity: Int
    private(set) public var count: Int
    public var isEmpty: Bool {
        return count == 0
    }
    
    init() {
        buffer = Array<Element?>()
        capacity = 0
        count = 0
    }
    
    init(minimumCapacity: Int) {
        self.init()
        capacity = nextCapacity(after: minimumCapacity)
        buffer = Array<Element?>(repeating: nil, count: capacity)
    }

    private mutating func reallocateArray(minimumCapacity: Int) {
        var newArray = Array<Element?>(repeating: nil, count: minimumCapacity)

        capacity = minimumCapacity

        var i: Int
        for e in buffer {
            guard let e = e else { continue }
            i = getIndexForKey(e.key)
            while newArray[i] != nil {
                i = (i + 1) % capacity
            }
            newArray[i] = e
        }

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
        
        guard let i = getValueIndexForKey(key) else {
            return nil
        }
        
        return buffer[i]?.value
    }

    @discardableResult
    public mutating func updateValue(_ value: Value?, forKey key: Key) -> Value? {
        
        guard let value = value else {
            return removeValue(forKey: key)
        }
        
        if count == capacity {
            reallocateArray(minimumCapacity: nextCapacity(after: capacity))
        }
        var i: Int = getIndexForKey(key)
        while buffer[i] != nil && buffer[i]?.key != key {
            i = (i+1) % capacity
        }
        let prev = buffer[i]
        buffer[i] = Element(key, value)
        if prev == nil {
            count += 1
        }
        return prev?.value
    }
    
    @discardableResult
    public mutating func removeValue(forKey key: Key) -> Value? {
        guard let i = getValueIndexForKey(key) else {
            return nil
        }
        let prev = buffer[i]
        buffer[i] = nil
        if prev != nil {
            count -= 1
        }
        return prev?.value
    }
    
    fileprivate func getIndexForKey(_ key: Key) -> Int {
        return (((key.hashValue) % capacity) + capacity) % capacity
    }
    
    fileprivate func getValueIndexForKey(_ key: Key) -> Int? {
        if isEmpty { return nil }
        var i: Int = getIndexForKey(key)
//        guard buffer[i] != nil else { return nil }
        
        if buffer[i]?.key != key {
            let j = i
            i += 1
            while i != j && buffer[i]?.key != key {
                i = (i+1) % capacity
            }
            
            if i == j { return nil }
        }
        return i
    }

    public subscript(key: Key) -> Value? {
        get {
            return getValue(forKey: key)
        }
        set {
            updateValue(newValue, forKey: key)
        }
    }
}
