//
//  ADL_Queue.swift
//  experiments
//
//  Created by Bahlreighn on 5/8/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import Foundation

protocol ADL_Queue {
    associatedtype Element
    var count: Int { get }
    var isEmpty: Bool { get }
    
    var peek: Element? { get }
    
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
}


private class _ADL_AnyQueueBase<Element>: ADL_Queue {
    init() {
        guard type(of: self) != _ADL_AnyQueueBase.self else {
            fatalError("_ADL_AnyQueueBase<Element> instances can not be created; create a subclass instance instead")
        }
    }
    
    var isEmpty: Bool {
        _abstract()
    }
    
    var count: Int {
        _abstract()
    }
    
    var peek: Element? {
        _abstract()
    }

    func enqueue(_ element: Element) {
        _abstract()
    }
    
    func dequeue() -> Element? {
        _abstract()
    }
}

private final class _ADL_AnyQueueBox<Concrete: ADL_Queue>: _ADL_AnyQueueBase<Concrete.Element> {
    internal var concrete: Concrete
    
    init(_ concrete: Concrete) {
        self.concrete = concrete
    }
    
    override var isEmpty: Bool {
        return concrete.isEmpty
    }
    
    override var count: Int {
        return concrete.count
    }
    
    override var peek: Concrete.Element? {
        return concrete.peek
    }
    
    override func enqueue(_ element: Concrete.Element) {
        concrete.enqueue(element)
    }
    
    override func dequeue() -> Concrete.Element? {
        return concrete.dequeue()
    }
}

final class ADL_AnyQueue<Element>: ADL_Queue {
    private let box: _ADL_AnyQueueBase<Element>
    
    init<Concrete: ADL_Queue>(_ concrete: Concrete) where Concrete.Element == Element {
        box = _ADL_AnyQueueBox(concrete)
    }
    
    var isEmpty: Bool {
        return box.isEmpty
    }
    
    var count: Int {
        return box.count
    }
    
    var peek: Element? {
        return box.peek
    }
    
    func enqueue(_ element: Element) {
        box.enqueue(element)
    }
    
    func dequeue() -> Element? {
        return box.dequeue()
    }
}

class ADL_Queue_SinglyLinkedList<Element>: ADL_Queue {
    fileprivate var start: ADL_SinglyLinkedList<Element>?
    fileprivate var end: ADL_SinglyLinkedList<Element>?

    var count: Int {
        return start?.count ?? 0
    }
    
    var isEmpty: Bool {
        return count == 0
    }
    
    public var peek: Element? {
        return start?.value
    }

    func enqueue(_ element: Element) {
        let newNode = ADL_SinglyLinkedList(element)
        if let end = end {
            end.next = newNode
        }
        else {
            start = newNode
        }
        end = newNode
    }
    
    @discardableResult
    func dequeue() -> Element? {
        let result = start?.value
        
        start = start?.next
        
        return result
    }
}

class ADL_Queue_DoublyLinkedList<Element>: ADL_Queue {
    fileprivate var buffer = ADL_DoublyLinkedList<Element>()
    
    var count: Int {
        return buffer.count
    }
    
    var isEmpty: Bool {
        return buffer.isEmpty
    }
    
    public var peek: Element? {
        return buffer.first
    }
    
    public func enqueue(_ element: Element) {
        buffer.append(element)
    }
    
    @discardableResult
    public func dequeue() -> Element? {
        guard !isEmpty else {
            return nil
        }
        return buffer.remove(at: 0)
    }
}

struct ADL_Queue_ADL_Array<Element>: ADL_Queue {
    fileprivate var bufferArray = ADL_Array<Element?>()
    fileprivate var headIndex = 0
    fileprivate let loadCountThreshold = 50
    fileprivate let loadThreshold = 0.34
    
    var count: Int {
        return bufferArray.count - headIndex
    }

    var isEmpty: Bool {
        return count == 0
    }
    
    var peek: Element? {
        if isEmpty {
            return nil
        }
        return bufferArray[headIndex]
    }
    
    mutating func enqueue(_ element: Element) {
        bufferArray.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> Element? {
        guard !bufferArray.isEmpty, let returnValue = bufferArray[headIndex] else {
            return nil
        }
        
        headIndex += 1
        
        optimize()
        
        return returnValue
    }
    
    var load: Double {
        return Double(headIndex) / Double(bufferArray.count)
    }
    
    mutating func optimize() {
        guard bufferArray.count > loadCountThreshold, load > loadThreshold else {
            return
        }
        let newBufferArray = ADL_Array<Element?>()
        newBufferArray.reserveCapacity(bufferArray.count)
        for i in 0 ..< count {
            newBufferArray.append(bufferArray[headIndex+i])
        }
        bufferArray = newBufferArray
        headIndex = 0
    }
}

struct ADL_Queue_Array<Element>: ADL_Queue {
    fileprivate var array = Array<Element?>()
    fileprivate var headIndex = 0
    fileprivate let loadCountThreshold = 50
    fileprivate let loadThreshold = 0.34
    
    var count: Int {
        return array.count - headIndex
    }
    
    var isEmpty: Bool {
        return count == 0
    }

    var peek: Element? {
        if isEmpty {
            return nil
        }

        return array[headIndex]
    }
    
    mutating func enqueue(_ element: Element) {
        array.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> Element? {
        guard headIndex < array.count, let returnValue = array[headIndex] else {
            return nil
        }
        
        headIndex += 1
        
        optimize()
        
        return returnValue
    }
    
    var load: Double {
        return Double(headIndex) / Double(array.count)
    }
    
    mutating func optimize() {
        guard array.count > loadCountThreshold && load > loadThreshold else {
            return
        }
        array.removeFirst(headIndex)
        headIndex = 0
    }
}
