//
//  XCTestCase+Extensions.swift
//  experimentsTests
//
//  Created by Bahlreighn on 5/10/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest

extension XCTestCase {
    func expectFatalError(
        expectedMessage: String,
        testcase: @escaping () -> Void
        ) {
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String? = nil
        
        FatalErrorUtil.replaceFatalErrorClosure { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }
        
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(assertionMessage, expectedMessage)
            
            FatalErrorUtil.restoreFatalErrorClosure()
        }
    }
    
    func expectPrecondition(
        expectedMessage: String,
        testcase: @escaping () -> Void
        ) {
        let expectation = self.expectation(description: "expectingPrecondition")
        var assertion: (condition: Bool, message: String)? = nil

        PreconditionUtil.replacePreconditionClosure { condition, message, _, _  in
            assertion = (condition, message)
            expectation.fulfill()
        }
        
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(assertion?.message, expectedMessage)
            PreconditionUtil.restorePreconditionClosure()
        }
    }

    func expectPreconditionFailure(
        expectedMessage: String,
        testcase: @escaping () -> Void
        ) {
        let expectation = self.expectation(description: "expectingPreconditionFailure")
        var assertionMessage: String? = nil
        
        PreconditionFailureUtil.replacePreconditionFailureClosure { message, _, _ -> Never in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }
        
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(assertionMessage, expectedMessage)
            PreconditionFailureUtil.restorePreconditionFailureClosure()
        }
    }
    
    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}
