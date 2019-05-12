import Foundation

public struct ADL_DoublyLinkList<Element>: Sequence {
    
    class Node {
        var data: Element
        var previous: Node?
        var next: Node?
        init(_ data: Element) {
            self.data = data
        }
    }

    public struct Iterator: IteratorProtocol {
        private var linkedList: ADL_DoublyLinkList<Element>!
        var node: Node?
        
        init(_ list: ADL_DoublyLinkList<Element>) {
            self.linkedList = list
            self.node = linkedList.list
        }
        
        @discardableResult
        public mutating func previous() -> Element? {
            guard let previousNode = node?.previous else {
                return nil
            }
            defer{ node = previousNode }
            return node?.data
        }

        @discardableResult
        public mutating func next() -> Element? {
            guard let nextNode = node?.next else {
                return nil
            }
            defer{ node = nextNode }
            return node?.data
        }
        
    }
    
    private(set) public var count = 0
    
    private var startNode: Node?
    private var endNode: Node?
    private var list: Node? {
        get {
            return startNode
        }
        set {
            startNode = newValue
        }
    }

    public init() {}
 
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var first: Element? {
        guard count > 0, let node = startNode else {
            return nil
        }
        return node.data
    }
    
    public var last: Element? {
        guard count > 0, let node = endNode else {
            return nil
        }
        return node.data
    }

    public var head: Element? {
        return first
    }
    
    public var tail: ADL_DoublyLinkList<Element>? {
        guard let list = list, count > 1 else {
            return nil
        }
        var newList = ADL_DoublyLinkList()
        newList.list = list.next
        newList.count = count - 1
        return newList
    }
    
    public __consuming func makeIterator() -> ADL_DoublyLinkList<Element>.Iterator {

        return Iterator(self)
    }
    
    public mutating func insert(_ datum: Element, at index: Int) {
        guard 0 <= index && index <= count else { preconditionFailure("index out of bounds")
        }

        let newNode = Node(datum)

        if index == 0 {
            if let nextNode = startNode?.next {
                nextNode.previous = newNode
            }
            
            newNode.next = startNode
            
            startNode = newNode
            
            if count == 0 {
                endNode = newNode
            }
        }
        else {
            var nodeAtIndex = startNode
            for _ in 1 ..< index {
                nodeAtIndex = nodeAtIndex?.next
            }
            
            if let nextNode = nodeAtIndex?.next {
                nextNode.previous = newNode
            }
            
            newNode.next = nodeAtIndex?.next
            newNode.previous = nodeAtIndex
            
            nodeAtIndex?.next = newNode
            
            if index == count {
                endNode = newNode
            }
        }
        count += 1
    }

    public mutating func append(_ datum: Element) {
        insert(datum, at: count)
    }

    public func getValue(at index: Int) -> Element {
        guard 0 <= index && index < count else {
            preconditionFailure("index out of bounds")
        }
        
        var nodeAtIndex = list
        for _ in 0 ..< index {
            nodeAtIndex = nodeAtIndex?.next
        }
        return nodeAtIndex!.data
    }

    public subscript(index: Int) -> Element {
        return getValue(at: index)
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> Element {
        guard 0 <= index && index < count else {
            preconditionFailure("index out of bounds")
        }

        var node: Node? = startNode

        if index == 0 {
            startNode = startNode?.next
            
            startNode?.previous = nil
            
            if count == 1 {
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
            
//            if index == count - 1 {
//                endNode = precedingNode
//            }
        }

        count -= 1
        return node!.data
    }
    
    @discardableResult
    public mutating func removeLast() -> Element {
        precondition(!isEmpty)
        
        return remove(at: count-1)
    }
}

extension ADL_DoublyLinkList: CustomStringConvertible {
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

extension ADL_DoublyLinkList: Equatable where Element: Equatable {
    public static func == (lhs: ADL_DoublyLinkList<Element>, rhs: ADL_DoublyLinkList<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (l,r) in zip(lhs, rhs) {
            if l != r { return false }
        }
        
        return true
    }
    
    public static func == (lhs: ADL_DoublyLinkList<Element>, rhs: Array<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (l,r) in zip(lhs, rhs) {
            if l != r { return false }
        }
        
        return true
    }
}
