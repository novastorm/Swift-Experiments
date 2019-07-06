/*
 *** Assumes Acyclical Singly Linked List ***
 */

import Foundation

public class ADL_SinglyLinkedList<Element> {
    
    var value: Element
    var next: ADL_SinglyLinkedList<Element>?

    public init(_ value: Element) {
        self.value = value
    }
}
extension ADL_SinglyLinkedList {
    public var count: Int {
        return 1 + (next?.count ?? 0)
    }
}

extension ADL_SinglyLinkedList {
    public func get(at index: Int) -> ADL_SinglyLinkedList<Element> {
        precondition(0 <= index && index < count, "SinglyLinkedList index is out of range")
        
        var nodeAtIndex: ADL_SinglyLinkedList<Element>! = self
        for _ in stride(from: index, to: 0, by: -1) {
            nodeAtIndex = nodeAtIndex.next
        }
        return nodeAtIndex
    }
}

extension ADL_SinglyLinkedList {

    public static func count(_ list: ADL_SinglyLinkedList<Element>?) -> Int {
        return list?.count ?? 0
    }

    public static func isEmpty(_ list: ADL_SinglyLinkedList<Element>?) -> Bool {
        return list == nil
    }
}
    
extension ADL_SinglyLinkedList {
    public static func insert(
        _ list: inout ADL_SinglyLinkedList<Element>?,
        _ newNode: ADL_SinglyLinkedList<Element>,
        at index: Int
        ) {
        precondition(0 <= index && index <= ADL_SinglyLinkedList.count(list), "SinglyLinkedList index is out of range")

        if index == 0 {
            newNode.next = list
            list = newNode
        }
        else {
            var nodeAtIndex: ADL_SinglyLinkedList<Element>! = list
            for _ in 1 ..< index {
                nodeAtIndex = nodeAtIndex.next
            }

            newNode.next = nodeAtIndex.next

            nodeAtIndex.next = newNode
        }
    }

    public static func append(
        _ list: inout ADL_SinglyLinkedList<Element>?,
        _ node: ADL_SinglyLinkedList<Element>
        ) {
        let count = ADL_SinglyLinkedList.count(list)
        ADL_SinglyLinkedList.insert(&list, node, at: count)
    }

    @discardableResult
    public static func remove(
        _ list: inout ADL_SinglyLinkedList<Element>?,
        at index: Int
        ) -> ADL_SinglyLinkedList<Element> {
        precondition(0 <= index && index < ADL_SinglyLinkedList.count(list), "SinglyLinkedLink index is out of range")

        var node = list
      
        
        if index == 0 {
            list = node?.next
        }
        else {
            var precedingNode = list
            for _ in 1 ..< index {
                precedingNode = precedingNode?.next
            }
            node = precedingNode?.next
            precedingNode?.next = node?.next
        }
        return node!
    }
    
}

extension ADL_SinglyLinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var separator = ""
        let _ = self.reduce(into: s, { (acc, node) in
            s += "\(separator)\(node.value)"
            separator = ", "
        })
        s += "]"
        return s
    }
}

extension ADL_SinglyLinkedList: Equatable where Element: Equatable {
    public static func == (lhs: ADL_SinglyLinkedList<Element>, rhs: ADL_SinglyLinkedList<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (l,r) in zip(lhs, rhs) {
            if l != r { return false }
        }
        
        return true
    }
    
    public static func == (lhs: ADL_SinglyLinkedList<Element>, rhs: Array<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (l,r) in zip(lhs, rhs) {
            if l.value != r { return false }
        }
        
        return true
    }
}

extension ADL_SinglyLinkedList: Sequence {

    public class Iterator: IteratorProtocol {
        private var node: ADL_SinglyLinkedList?
        
        init(_ list: ADL_SinglyLinkedList) {
            self.node = list
        }
        
        @discardableResult
        public func next() -> ADL_SinglyLinkedList? {
            defer{ node = node?.next }
            return node
        }
    }
    
    public __consuming func makeIterator() -> ADL_SinglyLinkedList<Element>.Iterator {
        return Iterator(self)
    }
}

extension ADL_SinglyLinkedList {
    public static func reverse(
        _ list: inout ADL_SinglyLinkedList<Element>.Element
        ) {
        var newHead: ADL_SinglyLinkedList<Element>!
        var currNode: ADL_SinglyLinkedList<Element>? = list
        var nextNode: ADL_SinglyLinkedList<Element>? = list.next
        
        while currNode != nil {
            currNode?.next = newHead
            newHead = currNode
            
            currNode = nextNode
            nextNode = currNode?.next
        }
        
        list = newHead
    }
}
