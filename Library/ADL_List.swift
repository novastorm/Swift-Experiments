import Foundation

protocol ADL_List: ADL_Collection {
    associatedtype Element
    var head: Element? { get }
    var tail: Self? { get }
}
