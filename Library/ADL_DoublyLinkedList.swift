import Foundation

public class ADL_DoublyLinkedList<Element> {
    var value: Element
    
    var previous: ADL_DoublyLinkedList?
    var next: ADL_DoublyLinkedList?
    
    public init(_ value: Element) {
        self.value = value
    }
}

extension ADL_DoublyLinkedList {
    public var count: Int {
        return previousNodesCount + 1 + nextNodesCount
    }
    
    // Assumes Acyclical
    public var previousNodesCount: Int {
        if let previous = previous {
            return 1 + previous.previousNodesCount
        }
        return 0
    }

    // Assumes Acyclical
    public var nextNodesCount: Int {
        if let next = next {
            return 1 + next.nextNodesCount
        }
        return 0
    }
}
    
extension ADL_DoublyLinkedList {
    // Assumes Acyclical
    public var startNode: ADL_DoublyLinkedList<Element>? {
        if let previous = previous {
            return previous.startNode
        }
        return self
    }
    
    // Assumes Acyclical
    public var endNode: ADL_DoublyLinkedList<Element>? {
        if let next = next {
            return next.endNode
        }
        return self
    }

//    public var first: Element? {
//        return startNode?.value
//    }
//
//    public var last: Element? {
//        return endNode?.value
//    }
//
//    public var head: Element? {
//        return first
//    }
//
//    public var tail: ADL_DoublyLinkedList<Element>? {
//        return startNode?.next
//    }
}
extension ADL_DoublyLinkedList {
    // Assumes Acyclical
    public func get(at index: Int) -> ADL_DoublyLinkedList<Element> {
        precondition(0 <= index && index < count, "DoublyLinkedList index is out of range")
        
        var nodeAtIndex: ADL_DoublyLinkedList<Element>! = self
        var index = index - 1
        while index >= 0 {
            nodeAtIndex = nodeAtIndex.next
            index -= 1
        }
        return nodeAtIndex
    }
//
//    public subscript(index: Int) -> Element {
//        return getValue(at: index)
//    }
}

extension ADL_DoublyLinkedList {
    public static func count(_ list: ADL_DoublyLinkedList<Element>?) -> Int {
        return list?.count ?? 0
    }
    
    public static func isEmpty(_ list: ADL_DoublyLinkedList<Element>?) -> Bool {
        return list == nil
    }
}

extension ADL_DoublyLinkedList {
    // Assumes Acyclical
    // assumes list points at the start of list
    public static func insert(
        _ list: inout ADL_DoublyLinkedList<Element>?,
        _ newNode: ADL_DoublyLinkedList<Element>,
        at index: Int
        ) {
        precondition(0 <= index && index <= ADL_DoublyLinkedList.count(list), "DoublyLinkedList index is out of range")

        if index == 0 {
            if let nextNode = list {
                nextNode.previous = newNode
            }
            
            newNode.next = list
            list = newNode
        }
        else {
            var nodeAtIndex : ADL_DoublyLinkedList<Element>! = list
            for _ in 1 ..< index {
                nodeAtIndex = nodeAtIndex.next
            }
            
            if let nextNode = nodeAtIndex.next {
                nextNode.previous = newNode
            }
            
            newNode.next = nodeAtIndex.next
            newNode.previous = nodeAtIndex
            
            nodeAtIndex.next = newNode
        }
    }

    public static func append(
        _ list: inout ADL_DoublyLinkedList<Element>?,
        _ node: ADL_DoublyLinkedList<Element>
        ) {
        let count = ADL_DoublyLinkedList.count(list)
        ADL_DoublyLinkedList.insert(&list, node, at: count)
    }

    // Assumes Acyclical
    @discardableResult
    public static func remove(
        _ list: inout ADL_DoublyLinkedList<Element>?,
        at index: Int
        ) -> ADL_DoublyLinkedList<Element> {
        precondition(0 <= index && index < ADL_DoublyLinkedList.count(list), "DoublyLinkedList index is out of range")

        var node = list?.startNode

        if index == 0 {
            
            let followingNode = node?.next
            followingNode?.previous = nil
            
            list = followingNode
        }
        else {
            for _ in 1 ... index {
                node = node?.next
            }
            let precedingNode = node?.previous
            let followingNode = node?.next
            
            precedingNode?.next = followingNode
            followingNode?.previous = precedingNode
        }

        return node!
    }
    
    @discardableResult
    static public func removeLast(
        _ list: inout ADL_DoublyLinkedList<Element>?
        ) -> ADL_DoublyLinkedList<Element> {
        precondition(list != nil, "Can't remove last element from an empty collection")
        
        return ADL_DoublyLinkedList.remove(&list, at: list!.count-1)
    }
}

extension ADL_DoublyLinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var separator = ""
        let _ = self.reduce(into: s, { (acc, e) in
            s += "\(separator)\(e.value)"
            separator = ", "
        })
        s += "]"
        return s
    }
}

extension ADL_DoublyLinkedList: Equatable where Element: Equatable {
    public static func == (lhs: ADL_DoublyLinkedList<Element>, rhs: ADL_DoublyLinkedList<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (l,r) in zip(lhs, rhs) {
            if l.value != r.value { return false }
        }
        
        return true
    }
    
    public static func == (lhs: ADL_DoublyLinkedList<Element>, rhs: Array<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (l,r) in zip(lhs, rhs) {
            if l.value != r { return false }
        }
        
        return true
    }
}

extension ADL_DoublyLinkedList: Sequence {
    public class Iterator: IteratorProtocol {
        private var node: ADL_DoublyLinkedList?
        
        init(_ list: ADL_DoublyLinkedList<Element>) {
            self.node = list
        }
        
        @discardableResult
        public func previous() -> ADL_DoublyLinkedList<Element>? {
            defer{ node = node?.previous }
            return node
        }
        
        @discardableResult
        public func next() -> ADL_DoublyLinkedList<Element>? {
            defer{ node = node?.next }
            return node
        }
    }
    
    public __consuming func makeIterator() -> ADL_DoublyLinkedList<Element>.Iterator {
        return Iterator(self)
    }
}
