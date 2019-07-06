import Foundation

class ADL_Graph<Element> where Element: Hashable {
    var value: Element
    var neighbors = Set<ADL_Graph<Element>>()

    public init(_ value: Element) {
        self.value = value
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
