import Foundation

class ADL_Graph<Element> where Element: Hashable {
    var value: Element
    var neighbors = Set<ADL_Graph<Element>>()

    public init(_ value: Element) {
        self.value = value
    }
}

extension ADL_Graph {
    public var count: Int {
        var aCount = 1
        for n in neighbors {
            aCount += n.count
        }
        return aCount
    }

}


extension ADL_Graph: Hashable {
    static func == (lhs: ADL_Graph<Element>, rhs: ADL_Graph<Element>) -> Bool {
        return lhs.value == rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

extension ADL_Graph {
    func traverseBreadthFirst(_ process: (Element) -> Void) {
        var pending = ADL_Queue_Array<ADL_Graph<Element>>()
        pending.enqueue(self)
        
        while let current = pending.dequeue() {
            for neighbor in current.neighbors {
                pending.enqueue(neighbor)
            }
            process(current.value)
        }
    }
}
