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

    public var head: Element? {
        return value
    }
    
    public var tail: ADL_SinglyLinkedList<Element>? {
        return next
    }
}

extension ADL_SinglyLinkedList {

    public static func count(_ list: ADL_SinglyLinkedList<Element>?) -> Int {
        return list?.count ?? 0
    }

    public static func isEmpty(_ list: ADL_SinglyLinkedList<Element>?) -> Bool {
        return list == nil
    }
    
//    public static func head(_ list: ADL_SinglyLinkedList<Element>?) -> Element? {
//        return list?.head
//    }
//
//    public static func tail(_ list: ADL_SinglyLinkedList<Element>?) -> ADL_SinglyLinkedList<Element>? {
//        return list?.tail
//    }

    public static func insert(_ list: inout ADL_SinglyLinkedList<Element>?, _ value: Element, at index: Int) {
        precondition(0 <= index && index <= ADL_SinglyLinkedList.count(list), "Array index is out of range")

        let newNode = ADL_SinglyLinkedList(value)

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

    public static func append(_ list: inout ADL_SinglyLinkedList<Element>?, _ value: Element) {
        ADL_SinglyLinkedList.insert(&list, value, at: ADL_SinglyLinkedList.count(list))
    }
    
    public static func get(_ list: ADL_SinglyLinkedList<Element>?, at index: Int) -> Element {
        precondition(0 <= index && index < ADL_SinglyLinkedList.count(list), "Array index is out of range")
        
        var nodeAtIndex: ADL_SinglyLinkedList<Element>! = list
        for _ in stride(from: index, to: 0, by: -1) {
            nodeAtIndex = nodeAtIndex.next
        }
        return nodeAtIndex.value
    }
    
    public static func update(_ list: ADL_SinglyLinkedList<Element>?, value: Element, at index: Int) {
        precondition(0 <= index && index < ADL_SinglyLinkedList.count(list), "Array index is out of range")
        
        var nodeAtIndex: ADL_SinglyLinkedList<Element>! = list
        for _ in 0 ..< index {
            nodeAtIndex = nodeAtIndex.next
        }
        nodeAtIndex.value = value
    }

    @discardableResult
    public static func remove(_ list: inout ADL_SinglyLinkedList<Element>?, at index: Int) -> Element {
        precondition(0 <= index && index < ADL_SinglyLinkedList.count(list), "Array index is out of range")

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
        return node!.value
    }
    
}
extension ADL_SinglyLinkedList {

//    public subscript(index: Int) -> Element {
//        get {
//            return getValue(at: index)
//        }
//        set {
//            precondition(0 <= index && index < count, "Array index is out of range")
//            precondition(index >= startIndex, "Negative Array index is out of range")
//            ADL_SinglyLinkedList.insert(self, newValue, at: index)
//        }
//    }
}
//
//}

extension ADL_SinglyLinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var separator = ""
        let _ = self.reduce(into: s, { (acc, e) in
            s += "\(separator)\(e)"
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
            if l != r { return false }
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
        public func next() -> Element? {
            defer{ node = node?.next }
            return node?.value
        }
    }
    
    public __consuming func makeIterator() -> ADL_SinglyLinkedList<Element>.Iterator {
        return Iterator(self)
    }
}
