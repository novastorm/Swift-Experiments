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
        mutating public func previous() -> Element? {
            guard let previousNode = node?.previous else {
                return nil
            }
            defer{ node = previousNode }
            return node?.data
        }

        @discardableResult
        mutating public func next() -> Element? {
            guard let nextNode = node?.next else {
                return nil
            }
            defer{ node = nextNode }
            return node?.data
        }
        
    }
    
    private var list: Node?
    private(set) public var count = 0
    
    private var start: Node?
    private var end: Node?
   
    public init() {}
 
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var first: Element? {
        guard let list = list, count > 0 else {
            return nil
        }
        return list.data
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
    
    mutating public func insert(_ datum: Element, at index: Int) {
        guard 0 <= index && index <= count else {
            return
        }

        let newNode = Node(datum)

        if index == 0 {
            newNode.next = list
            list = newNode
        }
        else {
            var nodeAtIndex = list
            for _ in 1 ..< index {
                nodeAtIndex = nodeAtIndex?.next
            }
            newNode.next = nodeAtIndex?.next
            nodeAtIndex?.next = newNode
        }
        count += 1
    }

    mutating public func append(_ datum: Element) {
        insert(datum, at: count)
    }

    public func getValue(at index: Int) -> Element {
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
    mutating public func remove(at index: Int) -> Element {
        var deletedNode: Node!
        if index == 0 {
            deletedNode = list
            list = list?.next
        }
        else {
            var precedingNode = list
            for _ in 1 ..< index {
                precedingNode = precedingNode?.next
            }
            deletedNode = precedingNode?.next
            precedingNode?.next = deletedNode?.next
        }
        count -= 1
        return deletedNode.data
    }
}
