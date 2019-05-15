import Foundation

public class ADL_SinglyLinkedList<Element>: Sequence {
    
    var value: Element!
    var next: ADL_SinglyLinkedList?

    public class Iterator: IteratorProtocol {
        private var node: ADL_SinglyLinkedList?
        
        init(_ list: ADL_SinglyLinkedList) {
            self.node = list.next
        }
        
        @discardableResult
        public func next() -> Element? {
            defer{ node = node?.next }
            return node?.value
        }
        
    }
    
    public var count: Int {
        return (value != nil ? 1 : 0) + (next?.count ?? 0)
    }
   
    public init() {}
 
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var first: Element? {
        guard count > 0, let node = next else {
            return nil
        }
        return node.value
    }
    
    public var head: Element? {
        return next?.value
    }
    
    public var tail: ADL_SinglyLinkedList? {
        if next == nil {
            return nil
        }
        
        let newList = ADL_SinglyLinkedList()

        newList.next = next?.next
        
        return newList
    }
    
    public __consuming func makeIterator() -> ADL_SinglyLinkedList<Element>.Iterator {
        return Iterator(self)
    }
    
    public func insert(_ value: Element, at index: Int) {
        guard 0 <= index && index <= count else {
            fatalError("index out of bounds")
        }

        let newNode = ADL_SinglyLinkedList()
        newNode.value = value

        if index == 0 {
            newNode.next = next
            next = newNode
        }
        else {
            var nodeAtIndex = next
            for _ in 1 ..< index {
                nodeAtIndex = nodeAtIndex?.next
            }
            
            newNode.next = nodeAtIndex?.next
            
            nodeAtIndex?.next = newNode
        }
    }

    public func append(_ value: Element) {
        insert(value, at: count)
    }

    public func getValue(at index: Int) -> Element {
        guard 0 <= index && index < count else {
            fatalError("index out of bounds")
        }

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
        guard 0 <= index && index < count else {
            fatalError("index out of bounds")
        }

        var node = next
        
        if index == 0 {
            next = node?.next
        }
        else {
            var precedingNode = next
            for _ in 1 ..< index {
                precedingNode = precedingNode?.next
            }
            node = precedingNode?.next
            precedingNode?.next = node?.next
        }
        return node!.value
    }
}

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
