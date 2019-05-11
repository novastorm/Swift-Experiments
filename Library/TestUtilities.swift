//
//  TestUtilities.swift
//  experimentsTests
//
//  Created by Bahlreighn on 5/10/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import Foundation

func fatalError(
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
    ) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

func precondition(
    _ condition: @autoclosure () -> Bool,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
    ) {
    PreconditionUtil.preconditionClosure(condition(), message(), file, line)
}

func preconditionFailure(
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
    ) -> Never {
    PreconditionFailureUtil.preconditionFailureClosure(message(), file, line)
}


struct FatalErrorUtil {
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }

    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
    
    static func replaceFatalErrorClosure(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }
    static func restoreFatalErrorClosure() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}

struct PreconditionUtil {
    private static let defaultPreconditionClosure = { Swift.precondition($0, $1, file: $2, line: $3) }
    
    static var preconditionClosure: (Bool, String, StaticString, UInt) -> () = defaultPreconditionClosure

    static func replacePreconditionClosure(closure: @escaping (Bool, String, StaticString, UInt) -> ()) {
        preconditionClosure = closure
    }
    
    static func restorePreconditionClosure() {
        preconditionClosure = defaultPreconditionClosure
    }
}

struct PreconditionFailureUtil {
    private static let defaultPreconditionFailureClosure = { Swift.preconditionFailure($0, file: $1, line: $2) }
    
    static var preconditionFailureClosure: (String, StaticString, UInt) -> Never = defaultPreconditionFailureClosure
    
    static func replacePreconditionFailureClosure(closure: @escaping (String, StaticString, UInt) -> Never) {
        preconditionFailureClosure = closure
    }
    
    static func restorePreconditionFailureClosure() {
        preconditionFailureClosure = defaultPreconditionFailureClosure
    }
}
