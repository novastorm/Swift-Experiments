//
//  ADL_Array.swift
//  experiments
//
//  Created by Bahlreighn on 5/9/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import Foundation

class ADL_ArrayImplementation<Element> {
    var array: UnsafeMutablePointer<Element>!
    private(set) public var capacity: Int = 0
    private(set) public var count: Int = 0
    public var isEmpty: Bool {
        return count == 0
    }
    
    init() {
        array = UnsafeMutablePointer<Element>.allocate(capacity: 0)
    }
    
    deinit {
        array.deallocate()
    }
    
    public func reserveCapacity(_ minimumCapacity: Int) {
        reallocateArray(minimumCapacity: minimumCapacity)
    }
    
    public var first: Element? {
        guard count > 0 else {
            return nil
        }
        return array.pointee
    }
    
    public var last: Element? {
        guard count > 0 else {
            return nil
        }
        return array.advanced(by: count - 1).pointee
    }
    
    public func insert(_ element: Element, at index: Int) {
        precondition(0 <= index && index <= count, "index out of bounds")
        if count >= capacity {
            reallocateArray(minimumCapacity: capacity)
        }

        array.advanced(by: index).pointee = element
        
        count += 1
    }
    
    public func append(_ element: Element) {
        insert(element, at: count)
    }
    
    public func getValue(at index: Int) -> Element {
        precondition(0 <= index && index < count, "index out of bounds")
        return array.advanced(by: index).pointee
    }
    
    public subscript(index: Int) -> Element {
        get {
            return getValue(at: index)
        }
        set {
            insert(newValue, at: index)
        }
    }
    
    @discardableResult
    public func remove(at index: Int) -> Element {
        precondition(0 <= index && index < count, "index out of bounds")
        let pointer = array.advanced(by: index)
        let results = pointer.pointee
        pointer.assign(from: pointer.advanced(by: 1), count: count - index)
        
        count -= 1
        
        return results
    }

    // MARK: - Helpers
    
    private func reallocateArray(minimumCapacity: Int) {
        let newCapacity = nextCapacity(after: minimumCapacity)
        let newArray = UnsafeMutablePointer<Element>.allocate(capacity: newCapacity)
        
        newArray.assign(from: array, count: count)
        
        array.deallocate()
        
        capacity = newCapacity
        array = newArray
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
}

extension ADL_ArrayImplementation: Sequence {
    public struct Iterator: IteratorProtocol {
        private var array: ADL_ArrayImplementation<Element>!
        private var index: Int = 0
        
        init(_ array: ADL_ArrayImplementation<Element>) {
            self.array = array
        }
        
        @discardableResult
        public mutating func next() -> Element? {
            guard index < array.count else { return nil }
            let results = array.getValue(at: index)
            index += 1
            return results
        }
    }

    __consuming func makeIterator() -> ADL_ArrayImplementation<Element>.Iterator {
        return Iterator(self)
    }
}

struct ADL_Array<Element> {
    private var array = ADL_ArrayImplementation<Element>()
    
    
}
