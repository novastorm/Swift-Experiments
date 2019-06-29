import Foundation

class ADL_BinaryTree<Element> {

    var value: Element?
    var left: ADL_BinaryTree?
    var right: ADL_BinaryTree?
}

class ADL_BinarySearchTree_Graph<Element>: ADL_BinaryTree<Element> where Element: Comparable{
    
    var count: Int {
        if value == nil {
           return 0
        }
        
        let left = self.left as? ADL_BinarySearchTree_Graph
        let right = self.right as? ADL_BinarySearchTree_Graph

        return 1 + (left?.count ?? 0) + (right?.count ?? 0)
    }

    override public init() {
        super.init()
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
