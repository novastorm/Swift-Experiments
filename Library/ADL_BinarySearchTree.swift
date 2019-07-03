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
}
