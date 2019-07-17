//
//  ADL_Array.swift
//  experiments
//
//  Created by Bahlreighn on 5/9/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import Foundation

public struct ADL_Array<Element> {
    fileprivate var buffer: UnsafeMutablePointer<Element>!
    private(set) public var capacity: Int = 0
    private(set) public var count: Int = 0
    public var isEmpty: Bool {
        return count == 0
    }
    
    init() {
        buffer = UnsafeMutablePointer<Element>.allocate(capacity: 0)
    }
    
//    deinit {
//        buffer.deallocate()
//    }
    
    public var first: Element? {
        guard count > 0 else {
            return nil
        }
        return buffer.pointee as Element
    }
    
    public var last: Element? {
        guard count > 0 else {
            return nil
        }
        return buffer.advanced(by: count - 1).pointee as Element
    }
    
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return count
    }
    
    public mutating func reserveCapacity(_ minimumCapacity: Int) {
        reallocateArray(minimumCapacity: minimumCapacity)
    }

    public mutating func insert(_ element: Element, at index: Int) {
        precondition(0 <= index && index <= count, "Array index is out of range")
        
        if count >= capacity {
            reallocateArray(minimumCapacity: capacity)
        }

        buffer.advanced(by: index).pointee = element
        
        count += 1
    }
    
    public mutating func append(_ element: Element) {
        insert(element, at: count)
    }
    
    public func getValue(at index: Int) -> Element {
        precondition(0 <= index && index < count, "Array index is out of range")
        
        return buffer.advanced(by: index).pointee
    }
    
    public subscript(index: Int) -> Element {
        get {
            return getValue(at: index)
        }
        set {
            precondition(0 <= index && index < count, "Array index is out of range")
            insert(newValue, at: index)
        }
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> Element {
        precondition(0 <= index && index < count, "Array index is out of range")
        
        let pointer = buffer.advanced(by: index)
        let results = pointer.pointee
        
        pointer.assign(from: pointer.advanced(by: 1), count: count - index)
        
        count -= 1
        
        return results
    }
    
    @discardableResult
    public mutating func removeLast() -> Element {
        precondition(!isEmpty, "Can't remove last element from an empty collection")

        return remove(at: count-1)
    }

    // MARK: - Helpers
    
    private mutating func reallocateArray(minimumCapacity: Int) {
        let newCapacity = nextCapacity(after: minimumCapacity)
        let newArray = UnsafeMutablePointer<Element>.allocate(capacity: newCapacity)
        
        newArray.assign(from: buffer, count: count)
        
        buffer.deallocate()
        
        capacity = newCapacity
        buffer = newArray
    }
    
    private func nextCapacity(after n: Int) -> Int {
        return nextDoubled(after: n)
    }
    
    private func nextDoubled(after n: Int) -> Int {
        return Int(pow(2, n > 0 ? log2(Double(n))+1 : 1.0))
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

extension ADL_Array: Sequence {
    public struct Iterator: IteratorProtocol {
        private var array: ADL_Array<Element>!
        private var index: Int = 0
        
        init(_ array: ADL_Array<Element>) {
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

    public __consuming func makeIterator() -> ADL_Array<Element>.Iterator {
        return Iterator(self)
    }
}

extension ADL_Array: CustomStringConvertible {
    public var description: String {
        var s = "["
        var separator = ""
        let _ = self.reduce(into: s) { acc, e in
            s += "\(separator)\(e)"
            separator = ", "
        }
        s += "]"
        
        return s
    }
}

extension ADL_Array: Equatable where Element: Equatable {
    public static func == (lhs: ADL_Array<Element>, rhs: ADL_Array<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (l,r) in zip (lhs, rhs) {
            guard l == r else { return false }
        }
        
        return true
    }
    
    public static func == (lhs: ADL_Array<Element>, rhs: Array<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (l, r) in zip(lhs, rhs) {
            guard l == r else { return false}
        }
        
        return true
    }
}
