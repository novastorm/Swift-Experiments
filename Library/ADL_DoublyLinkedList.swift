import Foundation

public class ADL_DoublyLinkedList<Element>: Sequence {
    
    var previous: ADL_DoublyLinkedList?
    var next: ADL_DoublyLinkedList?
    var value: Element!

    public class Iterator: IteratorProtocol {
        private var node: ADL_DoublyLinkedList?
        
        init(_ list: ADL_DoublyLinkedList<Element>) {
            self.node = list.next
        }
        
        @discardableResult
        public func previous() -> Element? {
            defer{ node = node?.previous }
            return node?.value
        }

        @discardableResult
        public func next() -> Element? {
            defer{ node = node?.next }
            return node?.value
        }
        
    }
    
    public var count: Int {
        return (value == nil ? 0 : 1) + (next?.count ?? 0)
    }
    
    private var startNode: ADL_DoublyLinkedList?
    private var endNode: ADL_DoublyLinkedList?

    public init() {}
 
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var first: Element? {
        return startNode?.value
    }
    
    public var last: Element? {
        return endNode?.value
    }

    public var head: Element? {
        return first
    }
    
    public var tail: ADL_DoublyLinkedList<Element>? {
        guard next == nil else {
            return nil
        }
        let newList = ADL_DoublyLinkedList()
        newList.next = next?.next
        return newList
    }
    
    public __consuming func makeIterator() -> ADL_DoublyLinkedList<Element>.Iterator {
        return Iterator(self)
    }
    
    public func insert(_ value: Element, at index: Int) {
        precondition(0 <= index && index <= count, "DoublyLinkedList index is out of range")

        let newNode = ADL_DoublyLinkedList()
        newNode.value = value

        if index == 0 {
            if let nextNode = startNode {
                nextNode.previous = newNode
            }
            if count == 0 {
                endNode = newNode
            }

            newNode.next = next
            next = newNode
            
            startNode = next
            
        }
        else {
            var nodeAtIndex = startNode
            for _ in 1 ..< index {
                nodeAtIndex = nodeAtIndex?.next
            }
            
            if let nextNode = nodeAtIndex?.next {
                nextNode.previous = newNode
            }

            if index == count {
                endNode = newNode
            }

            newNode.next = nodeAtIndex?.next
            newNode.previous = nodeAtIndex
            
            nodeAtIndex?.next = newNode
            
        }
    }

    public func append(_ datum: Element) {
        insert(datum, at: count)
    }

    public func getValue(at index: Int) -> Element {
        precondition(0 <= index && index < count, "DoublyLinkedList index is out of range")

        var nodeAtIndex = next
        for _ in 0 ..< index {
            nodeAtIndex = nodeAtIndex?.next
        }
        return nodeAtIndex!.value
    }

    public subscript(index: Int) -> Element {
        return getValue(at: index)
    }
    
    @discardableResult
    public func remove(at index: Int) -> Element {
        precondition(0 <= index && index < count, "DoublyLinkedList index is out of range")

        var node = startNode

        if index == 0 {
            startNode = startNode?.next
            
            startNode?.previous = nil
            next = startNode
            
            if count == 0 {
                endNode = nil
            }
        }
        else if index == count - 1{
            node = endNode
            
            let precedingNode = node?.previous
            precedingNode?.next = nil
            
            endNode = precedingNode
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

        return node!.value
    }
    
    @discardableResult
    public func removeLast() -> Element {
        precondition(!isEmpty, "Can't remove last element from an empty collection")
        
        return remove(at: count-1)
    }
}

extension ADL_DoublyLinkedList: CustomStringConvertible {
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

extension ADL_DoublyLinkedList: Equatable where Element: Equatable {
    public static func == (lhs: ADL_DoublyLinkedList<Element>, rhs: ADL_DoublyLinkedList<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (l,r) in zip(lhs, rhs) {
            if l != r { return false }
        }
        
        return true
    }
    
    public static func == (lhs: ADL_DoublyLinkedList<Element>, rhs: Array<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (l,r) in zip(lhs, rhs) {
            if l != r { return false }
        }
        
        return true
    }
}
