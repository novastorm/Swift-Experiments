import Foundation

class ADL_BinaryTree<Element> where Element: Hashable & Comparable {

    var value: Element
    var left: ADL_BinaryTree?
    var right: ADL_BinaryTree?
    
    public init(_ value: Element) {
        self.value = value
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    public var minValue: Element {
        var node: ADL_BinaryTree! = self
        
        while node.left != nil {
            node = node.left
        }
        
        return node.value
    }
    
    public var maxValue: Element {
        var node: ADL_BinaryTree! = self
        
        while node.right != nil {
            node = node.right
        }
        
        return node.value
    }
    
    public func traverseBreadthFirst(_ process: (Element) -> Void) {
        let pending = ADL_Queue_Array<ADL_BinaryTree<Element>>()
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

class ADL_BinarySearchTree<Element> where Element: Hashable & Comparable {
    
    var root: ADL_BinaryTree<Element>?
    
    var count: Int {
        return root?.count ?? 0
    }

    public var isEmpty: Bool {
        return count == 0
    }

    func insert(_ element: Element) {

    }

    func removeLeft() -> ADL_BinarySearchTree_Graph?{
        guard let result = self.left as? ADL_BinarySearchTree_Graph else {
            return nil
        }

        let left = self.left as? ADL_BinarySearchTree_Graph
        if right != nil {
            self.left = left?.popRightMost()
        }
        else {
            self.left = left?.left
        }

        result.left = nil
        result.right = nil

        return result
    }

    func removeRight() -> ADL_BinarySearchTree_Graph?{
        guard let result = self.right as? ADL_BinarySearchTree_Graph else {
            return nil
        }

        let right = self.right as? ADL_BinarySearchTree_Graph
        if left != nil {
            self.right = right?.popLeftMost()
        }
        else {
            self.right = right?.right
        }

        result.left = nil
        result.right = nil

        return result
    }

    func popLeftMost() -> ADL_BinarySearchTree_Graph? {
        var prev: ADL_BinarySearchTree_Graph!
        var node: ADL_BinarySearchTree_Graph? = self

        while node?.left != nil {
            prev = node
            node = node?.left as? ADL_BinarySearchTree_Graph
        }

        if let prev = prev {
            prev.left = nil
        }

        return node
    }

    func popRightMost() -> ADL_BinarySearchTree_Graph? {
        var prev: ADL_BinarySearchTree_Graph!
        var node: ADL_BinarySearchTree_Graph? = self

        while node?.right != nil {
            prev = node
            node = node?.right as? ADL_BinarySearchTree_Graph
        }

        if let prev = prev {
            prev.right = nil
        }

        return node
    }
}
