import Foundation

class ADL_BinarySearchTree<Element>: ADL_BinaryTree<Element> where Element: Comparable {
    var parent: ADL_BinaryTree<Element>?
    
    public var minNode: ADL_BinaryTree<Element> {
        var node: ADL_BinaryTree! = self
        
        while let left = node.left {
            node = left
        }
        
        return node
    }
    
    public var minValue: Element {
        return minNode.value
    }
    
    public var maxNode: ADL_BinaryTree<Element> {
        var node: ADL_BinaryTree! = self
        
        while let right = node.right {
            node = right
        }
        
        return node
    }
    
    public var maxValue: Element {
        return maxNode.value
    }

    func insert(_ element: Element) {

    }

//    func removeLeft() -> ADL_BinaryTree?{
//        guard let result = self.left as? ADL_BinarySearchTree_Graph else {
//            return nil
//        }
//
//        let left = self.left as? ADL_BinarySearchTree_Graph
//        if right != nil {
//            self.left = left?.popRightMost()
//        }
//        else {
//            self.left = left?.left
//        }
//
//        result.left = nil
//        result.right = nil
//
//        return result
//    }

//    func removeRight() -> ADL_BinarySearchTree_Graph?{
//        guard let result = self.right as? ADL_BinarySearchTree_Graph else {
//            return nil
//        }
//
//        let right = self.right as? ADL_BinarySearchTree_Graph
//        if left != nil {
//            self.right = right?.popLeftMost()
//        }
//        else {
//            self.right = right?.right
//        }
//
//        result.left = nil
//        result.right = nil
//
//        return result
//    }

//    func popLeftMost() -> ADL_BinarySearchTree_Graph? {
//        var prev: ADL_BinarySearchTree_Graph!
//        var node: ADL_BinarySearchTree_Graph? = self
//
//        while node?.left != nil {
//            prev = node
//            node = node?.left as? ADL_BinarySearchTree_Graph
//        }
//
//        if let prev = prev {
//            prev.left = nil
//        }
//
//        return node
//    }

//    func popRightMost() -> ADL_BinarySearchTree_Graph? {
//        var prev: ADL_BinarySearchTree_Graph!
//        var node: ADL_BinarySearchTree_Graph? = self
//
//        while node?.right != nil {
//            prev = node
//            node = node?.right as? ADL_BinarySearchTree_Graph
//        }
//
//        if let prev = prev {
//            prev.right = nil
//        }
//
//        return node
//    }
}
