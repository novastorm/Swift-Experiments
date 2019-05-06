import Foundation

protocol ADL_Collection {
    associatedtype Element
    var isEmpty: Bool { get }
    var count: Int { get }
    var first: Self.Element? { get }
}

protocol ADL_IteratorProtocol {
    associatedtype Element
    var value: Self.Element { get }
    mutating func next()
}
