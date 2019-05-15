//
//  ADL_Stack.swift
//  experiments
//
//  Created by Bahlreighn on 5/8/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import Foundation

protocol ADL_Stack {
    associatedtype Element
    var isEmpty: Bool { get }
    var count: Int { get }
    
    var peek: Element? { get }
    
    func push(_ element: Element)
    func pop() -> Element?
}

private class _ADL_AnyStackBase<Element>: ADL_Stack {
    init() {
        guard type(of: self) != _ADL_AnyStackBase.self else {
            fatalError("_ADL_AnyStackBase<Element> instances can not be created; create a subclass instance instead")
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

    func push(_ element: Element) {
        _abstract()
    }
    
    func pop() -> Element? {
        _abstract()
    }
}

private final class _ADL_AnyStackBox<Concrete: ADL_Stack>: _ADL_AnyStackBase<Concrete.Element> {
    internal let concrete: Concrete
    
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
    
    override func push(_ element: Concrete.Element) {
        concrete.push(element)
    }
    
    override func pop() -> Concrete.Element? {
        return concrete.pop()
    }
}

final class ADL_AnyStack<Element>: ADL_Stack {
    private let box: _ADL_AnyStackBase<Element>
    
    init<Concrete: ADL_Stack>(_ concrete: Concrete) where Concrete.Element == Element {
        box = _ADL_AnyStackBox(concrete)
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
    
    func push(_ element: Element) {
        box.push(element)
    }
    
    func pop() -> Element? {
        return box.pop()
    }
    
}

class ADL_Stack_SinglyLinkedList<Element>: ADL_Stack {
    
    private var stack: ADL_SinglyLinkedList<Element>!
    
    public init() {
        stack = ADL_SinglyLinkedList<Element>()
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public var count: Int {
        return stack.count
    }
    
    public var peek: Element? {
        return stack.first
    }

    public func push(_ element: Element) {
        stack.insert(element, at: 0)
    }
    
    @discardableResult
    public func pop() -> Element? {
        guard !stack.isEmpty else {
            return nil
        }
        return stack.remove(at: 0)
    }
}

class ADL_Stack_DoublyLinkedList<Element>: ADL_Stack {
    private var stack: ADL_DoublyLinkedList<Element>!
    
    public init() {
        stack = ADL_DoublyLinkedList<Element>()
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public var count: Int {
        return stack.count
    }
    
    public var peek: Element? {
        return stack.last
    }
    
    public func push(_ element: Element) {
        stack.append(element)
    }
    
    @discardableResult
    public func pop() -> Element? {
        guard !stack.isEmpty else {
            return nil
        }
        return stack.removeLast()
    }
}

class ADL_Stack_Array<Element>: ADL_Stack {
    private var stack = ADL_ArrayImplementation<Element>()
    
    public init() { }
    
    var isEmpty: Bool {
        return stack.isEmpty
    }
    
    var count: Int {
        return stack.count
    }
    
    var peek: Element? {
        return stack.last
    }
    
    func push(_ element: Element) {
        stack.append(element)
    }
    
    @discardableResult
    func pop() -> Element? {
        guard !stack.isEmpty else {
            return nil
        }
        return stack.removeLast()
    }
    
    
}
