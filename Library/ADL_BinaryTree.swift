import Foundation

class ADL_BinaryTree<Element> {

    var value: Element
    var left: ADL_BinaryTree?
    var right: ADL_BinaryTree?
    
    public init(_ value: Element) {
        self.value = value
    }
    
    public var count: Int {
        return 1 + (left?.count ?? 0) + (right?.count ?? 0)
    }

    public func traverseBreadthFirst(_ process: (Element) -> Void) {
        var pending = ADL_Queue_Array<ADL_BinaryTree<Element>>()
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
    
    public func traversePreOrder(_ process: (Element) -> Void) {
        process(value)
        left?.traversePreOrder(process)
        right?.traversePreOrder(process)
    }
    
    public func traverseInOrder(_ process: (Element) -> Void) {
        left?.traverseInOrder(process)
        process(value)
        right?.traverseInOrder(process)
    }
    
    public func traversePostOrder(_ process: (Element) -> Void) {
        left?.traversePostOrder(process)
        right?.traversePostOrder(process)
        process(value)
    }
    
    public func traverseOutOrder(_ process: (Element) -> Void) {
        right?.traverseOutOrder(process)
        process(value)
        left?.traverseOutOrder(process)
    }
}

extension ADL_BinaryTree {
    public static func count(_ tree: ADL_BinaryTree<Element>?) -> Int {
        return tree?.count ?? 0
    }
    
    public static func isEmpty(_ tree: ADL_BinaryTree<Element>?) -> Bool {
        return tree == nil
    }
}
