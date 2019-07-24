import Foundation

protocol ADL_BinaryTree {
    associatedtype Element

    var count: Int { get }
    var isEmpty: Bool { get }
    
    var breadthFirstIterator: AnyIterator<Element> { get }
    var preOrderIterator: AnyIterator<Element> { get }
    var inOrderIterator: AnyIterator<Element> { get }
    var outOrderIterator: AnyIterator<Element> { get }
    var postOrderIterator: AnyIterator<Element> { get }
}

protocol ADL_BinaryTreeNode {
    associatedtype Element
    
    var value: Element { get set }
    var left: Self? { get set }
    var right: Self? { get set }
}

extension ADL_BinaryTreeNode {
    public var count: Int {
        return 1 + (left?.count ?? 0) + (right?.count ?? 0)
    }
}


final class ADL_BinaryTreeNode_Recursive<Element>: ADL_BinaryTreeNode , ADL_BinaryTree {
    
    var value: Element
    var left: ADL_BinaryTreeNode_Recursive?
    var right: ADL_BinaryTreeNode_Recursive?

    init(_ value: Element) {
        self.value = value
    }

    init(_ value: Element,
         _ left:ADL_BinaryTreeNode_Recursive? = nil,
         _ right: ADL_BinaryTreeNode_Recursive? = nil
    ) {
        self.value = value
        self.left = left
        self.right = right
    }

    public var count: Int {
        return 1 + (left?.count ?? 0) + (right?.count ?? 0)
    }
    
    var isEmpty: Bool {
        return count == 0
    }
    
    public func traverseBreadthFirst(_ process: (Element) -> Void) {
        var pending = ADL_Queue_Array<ADL_BinaryTreeNode_Recursive<Element>>()
        pending.enqueue(self)
        
        while let current = pending.dequeue() {
            process(current.value)
            if let node = current.left {
                pending.enqueue(node)
            }
            if let node = current.right {
                pending.enqueue(node)
            }
        }
    }
    
    public var breadthFirstIterator: AnyIterator<Element> {
        var results = [Element]()
        traverseBreadthFirst { (e) in
            results.append(e)
        }
        
        return AnyIterator<Element>(results.makeIterator())
    }
    
    public func traversePreOrder(_ process: (Element) -> Void) {
        process(value)
        left?.traversePreOrder(process)
        right?.traversePreOrder(process)
    }
    
    public var preOrderIterator: AnyIterator<Element> {
        var results = [Element]()
        traversePreOrder { (e) in
            results.append(e)
        }
        
        return AnyIterator<Element>(results.makeIterator())
    }

    public func traverseInOrder(_ process: (Element) -> Void) {
        left?.traverseInOrder(process)
        process(value)
        right?.traverseInOrder(process)
    }
    
    public var inOrderIterator: AnyIterator<Element> {
        var results = [Element]()
        traverseInOrder { (e) in
            results.append(e)
        }
        
        return AnyIterator<Element>(results.makeIterator())
    }

    public func traverseOutOrder(_ process: (Element) -> Void) {
        right?.traverseOutOrder(process)
        process(value)
        left?.traverseOutOrder(process)
    }
    
    public var outOrderIterator: AnyIterator<Element> {
        var results = [Element]()
        traverseOutOrder { (e) in
            results.append(e)
        }
        
        return AnyIterator<Element>(results.makeIterator())
    }

    public func traversePostOrder(_ process: (Element) -> Void) {
        left?.traversePostOrder(process)
        right?.traversePostOrder(process)
        process(value)
    }
    
    public var postOrderIterator: AnyIterator<Element> {
        var results = [Element]()
        traversePostOrder { (e) in
            results.append(e)
        }
        
        return AnyIterator<Element>(results.makeIterator())
    }
}

extension ADL_BinaryTreeNode_Recursive {
    public static func count(_ tree: ADL_BinaryTreeNode_Recursive?) -> Int {
        return tree?.count ?? 0
    }
    
    public static func isEmpty(_ tree: ADL_BinaryTreeNode_Recursive?) -> Bool {
        return tree == nil
    }
}
