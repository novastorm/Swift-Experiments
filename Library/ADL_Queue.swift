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
    var isEmpty: Bool { get }
    var count: Int { get }
    
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

class ADL_Queue_SinglyLinkedList<Element>: ADL_SinglyLinkedList<Element>, ADL_Queue {
    
    public var peek: Element? {
        return first
    }

    public func enqueue(_ element: Element) {
        append(element)
    }
    
    @discardableResult
    public func dequeue() -> Element? {
        guard !isEmpty else {
            return nil
        }
        return remove(at: 0)
    }
}

class ADL_Queue_DoublyLinkedList<Element>: ADL_DoublyLinkedList<Element>, ADL_Queue {
    
    public var peek: Element? {
        return first
    }
    
    public func enqueue(_ element: Element) {
        append(element)
    }
    
    @discardableResult
    public func dequeue() -> Element? {
        guard !isEmpty else {
            return nil
        }
        return remove(at: 0)
    }
}

class ADL_Queue_Array<Element>: ADL_Array<Element>, ADL_Queue {
    
    var peek: Element? {
        return first
    }
    
    func enqueue(_ element: Element) {
        append(element)
    }
    
    @discardableResult
    func dequeue() -> Element? {
        guard !isEmpty else {
            return nil
        }
        return remove(at: 0)
    }
}
