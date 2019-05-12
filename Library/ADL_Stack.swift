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

class ADL_Stack_SinglyLinkedList<Element>: ADL_Stack {
    
    private var stack: ADL_SinglyLinkList<Element>!
    
    public init() {
        stack = ADL_SinglyLinkList<Element>()
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
        if stack.count == 0 {
            preconditionFailure("pop empty stack")
        }
        return stack.remove(at: 0)
    }
}

class ADL_Stack_DoublyLinkedList<Element>: ADL_Stack {
    private var stack: ADL_DoublyLinkList<Element>!
    
    public init() {
        stack = ADL_DoublyLinkList<Element>()
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
    
    public func pop() -> Element? {
        return stack.removeLast()
    }
}

class ADL_Stack_Array<Element>: ADL_Stack {
    private var stack = [Element]()
    
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
    
    func pop() -> Element? {
        return stack.removeLast()
    }
    
    
}
