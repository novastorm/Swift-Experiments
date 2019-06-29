import Foundation

@inline(never)
@usableFromInline
internal func _abstract(
    file: StaticString = #file,
    line: UInt = #line
    ) -> Never {
    fatalError("Method must be overridden", file: file, line: line)
}
