import Foundation

protocol ADL_BinaryTree_Iterative {
    associatedtype Element
    func traverseBreadthFirstIteratively(_ process: (Element) -> Void)
    func traversePreOrderIteratively(_ process: (Element) -> Void)
    func traverseInOrderIteratively(_ process: (Element) -> Void)
    func traverseOutOrderIteratively(_ process: (Element) -> Void)
    func traversePostOrderIteratively(_ process: (Element) -> Void)
}

protocol ADL_BinaryTree_Iterator {
    associatedtype Element
    var breadthFirstIterator: AnyIterator<Element> { get }
    var preOrderIterator: AnyIterator<Element> { get }
    var inOrderIterator: AnyIterator<Element> { get }
    var outOrderIterator: AnyIterator<Element> { get }
    var postOrderIterator: AnyIterator<Element> { get }
}

protocol ADL_BinaryTree_Recursive {
    associatedtype Element
    func traversePreOrderRecursively(_ process: (Element) -> Void)
    func traverseInOrderRecursively(_ process: (Element) -> Void)
    func traverseOutOrderRecursively(_ process: (Element) -> Void)
    func traversePostOrderRecursively(_ process: (Element) -> Void)
}

class ADL_BinaryTreeNode<Element> {
    var value: Element
    var left: ADL_BinaryTreeNode<Element>?
    var right: ADL_BinaryTreeNode<Element>?
    
    init(_ value: Element,
         _ left: ADL_BinaryTreeNode<Element>? = nil,
         _ right: ADL_BinaryTreeNode<Element>? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

extension ADL_BinaryTreeNode {
    public var count: Int {
        return 1 + (left?.count ?? 0) + (right?.count ?? 0)
    }
}

class ADL_BinaryTree<Element> {
    var root: ADL_BinaryTreeNode<Element>?
    var count: Int {
        return root?.count ?? 0
    }
    var isEmpty: Bool {
        return root == nil
    }
    
    init(_ root: ADL_BinaryTreeNode<Element>) {
        self.root = root
    }
}

extension ADL_BinaryTree: ADL_BinaryTree_Recursive {
    func traversePreOrderRecursively(_ process: (Element) -> Void) {
        func helper(_ node: ADL_BinaryTreeNode<Element>, _ process: (Element) -> Void) {
            process(node.value)
            if node.left != nil {
                helper(node.left!, process)
            }
            if node.right != nil {
                helper(node.right!, process)
            }
        }
        helper(root!, process)
    }
    
    func traverseInOrderRecursively(_ process: (Element) -> Void) {
        func helper(_ node: ADL_BinaryTreeNode<Element>, _ process: (Element) -> Void) {
            if node.left != nil {
                helper(node.left!, process)
            }
            process(node.value)
            if node.right != nil {
                helper(node.right!, process)
            }
        }
        helper(root!, process)
    }
    
    func traverseOutOrderRecursively(_ process: (Element) -> Void) {
        func helper (_ node: ADL_BinaryTreeNode<Element>, _ process: (Element) -> Void) {
            if node.right != nil {
                helper(node.right!, process)
            }
            process(node.value)
            if node.left != nil {
                helper(node.left!, process)
            }
        }
        helper(root!, process)
    }
    
    func traversePostOrderRecursively(_ process: (Element) -> Void) {
        func helper(_ node: ADL_BinaryTreeNode<Element>, _ process: (Element) -> Void) {
            if node.left != nil {
                helper(node.left!, process)
            }
            if node.right != nil {
                helper(node.right!, process)
            }
            process(node.value)
        }
        helper(root!, process)
    }
}

extension ADL_BinaryTree: ADL_BinaryTree_Iterative {
    public func traverseBreadthFirstIteratively(_ process: (Element) -> Void) {
        if self.root == nil {
            return
        }
        
        var pending = ADL_Queue_Array<ADL_BinaryTreeNode<Element>>()
        pending.enqueue(self.root!)
        
        while let current = pending.dequeue() {
            if let node = current.left {
                pending.enqueue(node)
            }
            if let node = current.right {
                pending.enqueue(node)
            }
            process(current.value)
        }
    }
    
    func traversePreOrderIteratively(_ process: (Element) -> Void) {
        if self.root == nil {
            return
        }
        
        let pending = ADL_Stack_Array<ADL_BinaryTreeNode<Element>>()
        pending.push(self.root!)
        
        while let current = pending.pop() {
            if let node = current.right {
                pending.push(node)
            }
            if let node = current.left {
                pending.push(node)
            }
            process(current.value)
        }
    }
    
    func traverseInOrderIteratively(_ process: (Element) -> Void) {
        if self.root == nil {
            return
        }
        
        let pending = ADL_Stack_Array<ADL_BinaryTreeNode<Element>>()
        
        var node = self.root
        while node != nil {
            pending.push(node!)
            node = node!.left
        }
        
        while let next = pending.pop() {
            node = next.right
            while node != nil {
                pending.push(node!)
                node = node!.left
            }
            process(next.value)
        }
    }
    
    func traverseOutOrderIteratively(_ process: (Element) -> Void) {
        if self.root == nil {
            return
        }
        
        let pending = ADL_Stack_Array<ADL_BinaryTreeNode<Element>>()
        
        var node = self.root
        while node != nil {
            pending.push(node!)
            node = node!.right
        }
        
        while let next = pending.pop() {
            node = next.left
            while node != nil {
                pending.push(node!)
                node = node!.right
            }
            process(next.value)
        }
    }
    
    func traversePostOrderIteratively(_ process: (Element) -> Void) {
        
        func insertNodes(into pending: ADL_AnyStack<ADL_BinaryTreeNode<Element>>, from node: ADL_BinaryTreeNode<Element>) {
            var curr: ADL_BinaryTreeNode<Element>? = node
            while curr != nil {
                if curr!.right != nil {
                    pending.push(curr!.right!)
                }
                pending.push(curr!)
                curr = curr!.left
            }
        }
        
        let pending = ADL_Stack_Array<ADL_BinaryTreeNode<Element>>()
        insertNodes(into: ADL_AnyStack(pending), from: self.root!)
        
        var node: ADL_BinaryTreeNode<Element>?
        while let next = pending.pop() {
            node = next
            if node!.right != nil && !pending.isEmpty && node!.right === pending.peek {
                pending.pop()
                pending.push(node!)
                insertNodes(into: ADL_AnyStack(pending), from: node!.right!)
            }
            else {
                process(next.value)
            }
        }
    }
}

extension ADL_BinaryTree: ADL_BinaryTree_Iterator {
    class BreadthFirstIterator: IteratorProtocol {
        private var pending = ADL_Queue_Array<ADL_BinaryTreeNode<Element>?>()

        init(_ node: ADL_BinaryTreeNode<Element>?) {
            if let node = node {
                pending.enqueue(node)
            }
        }
        
        func next() -> Element? {
            guard let next = pending.dequeue() else {
                return nil
            }
            
            if let node = next!.left {
                pending.enqueue(node)
            }
            if let node = next!.right {
                pending.enqueue(node)
            }
            return next!.value
        }
    }
    
    class PreOrderIterator: IteratorProtocol {
        private var pending = ADL_Stack_Array<ADL_BinaryTreeNode<Element>?>()
        
        init(_ node: ADL_BinaryTreeNode<Element>?) {
            if let node = node {
                pending.push(node)
            }
        }
        
        func next() -> Element? {
            guard let next = pending.pop() else {
                return nil
            }
            
            if let node = next!.right {
                pending.push(node)
            }
            if let node = next!.left {
                pending.push(node)
            }
            
            return next!.value
        }
    }
    
    class InOrderIterator: IteratorProtocol {
        private var pending = ADL_Stack_Array<ADL_BinaryTreeNode<Element>?>()
        
        init(_ node: ADL_BinaryTreeNode<Element>?) {
            if node == nil {
                return
            }
            var curr = node
            while curr != nil {
                pending.push(curr!)
                curr = curr!.left
            }
        }
        
        func next() -> Element? {
            guard let next = pending.pop() else {
                return nil
            }
            
            var curr = next?.right
            while curr != nil {
                pending.push(curr!)
                curr = curr!.left
            }
            
            return next!.value
        }
    }
    
    class OutOrderIterator: IteratorProtocol {
        private var pending = ADL_Stack_Array<ADL_BinaryTreeNode<Element>?>()
        
        init(_ node: ADL_BinaryTreeNode<Element>?) {
            if node == nil {
                return
            }
            var curr = node
            while curr != nil {
                pending.push(curr!)
                curr = curr!.right
            }
        }
        
        func next() -> Element? {
            guard let next = pending.pop() else {
                return nil
            }
            
            var curr = next?.left
            while curr != nil {
                pending.push(curr!)
                curr = curr!.right
            }
            
            return next!.value
        }
    }
    
    class PostOrderIterator: IteratorProtocol {
        
        let pending = ADL_Stack_Array<ADL_BinaryTreeNode<Element>>()
        
        func insertNodes(into pending: ADL_AnyStack<ADL_BinaryTreeNode<Element>>, from node: ADL_BinaryTreeNode<Element>) {
            var curr: ADL_BinaryTreeNode<Element>? = node
            while curr != nil {
                if curr!.right != nil {
                    pending.push(curr!.right!)
                }
                pending.push(curr!)
                curr = curr!.left
            }
        }
        
        init(_ node: ADL_BinaryTreeNode<Element>?) {
            if node == nil {
                return
            }
            insertNodes(into: ADL_AnyStack(pending), from: node!)
        }
        
        func next() -> Element? {
            while let node = pending.pop() {
                if node.right != nil && !pending.isEmpty && node.right === pending.peek {
                    pending.pop()
                    pending.push(node)
                    insertNodes(into: ADL_AnyStack(pending), from: node.right!)
                }
                else {
                    return node.value
                }
            }
            
            return nil
        }
    }
        
    var breadthFirstIterator: AnyIterator<Element> {
        return AnyIterator(BreadthFirstIterator(self.root))
    }
    
    var preOrderIterator: AnyIterator<Element> {
        return AnyIterator(PreOrderIterator(self.root))
    }
    
    var inOrderIterator: AnyIterator<Element> {
        return AnyIterator(InOrderIterator(self.root))
    }
    
    var outOrderIterator: AnyIterator<Element> {
        return AnyIterator(OutOrderIterator(self.root))
    }
    
    var postOrderIterator: AnyIterator<Element> {
        return AnyIterator(PostOrderIterator(self.root))
    }
}
