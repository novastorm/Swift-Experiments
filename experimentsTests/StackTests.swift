//
//  StackTests.swift
//  experimentsTests
//
//  Created by Bahlreighn on 5/11/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest
@testable import experiments

//protocol StackProtocolTests {
//    associatedtype TestType
//
//    var stack: ADL_StackProtocol { get set } where TestType: Element
//
//    func test_stackInitialization()
//    func test_stackPush()
//    func test_stackPop()
//}
//
//extension StackProtocolTests {
//    func test_stackInitialization() {
//        XCTAssertTrue(stack.isEmpty)
//        XCTAssertEqual(stack.count, 0)
//        XCTAssertNil(stack.peek)
//        expectPreconditionFailure(expectedMessage: "pop empty stack") {
//            self.stack.pop()
//        }
//    }
//
//    func test_stackPush() {
//        for i in 0 ..< 3 {
//            stack.push(i)
//            XCTAssertFalse(stack.isEmpty)
//            XCTAssertEqual(stack.peek, i)
//            XCTAssertEqual(stack.count, i+1)
//        }
//    }
//
//    func test_stackPop() {
//        for i in 0 ..< 3 {
//            stack.push(i)
//            XCTAssertEqual(stack.peek, i)
//        }
//
//        for i in stride(from: 2, through: 0, by: -1) {
//            XCTAssertEqual(stack.peek, i)
//            XCTAssertEqual(stack.pop(), i)
//            XCTAssertEqual(stack.count, i)
//        }
//    }
//}


class SinglyLinkedListStackTests: XCTestCase {
    typealias TestType = Int
    var stack: ADL_Stack_SinglyLinkedList<TestType>!
    
    override func setUp() {
        stack = ADL_Stack_SinglyLinkedList<TestType>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_stackInitialization() {
        XCTAssertTrue(stack.isEmpty)
        XCTAssertEqual(stack.count, 0)
        XCTAssertNil(stack.peek)
    }
    
    func test_stackPush() {
        for i in 0 ..< 3 {
            stack.push(i)
            XCTAssertFalse(stack.isEmpty)
            XCTAssertEqual(stack.peek, i)
            XCTAssertEqual(stack.count, i+1)
        }
    }
    
    func test_stackPop() {
        XCTAssertNil(stack.pop())
        for i in 0 ..< 3 {
            stack.push(i)
            XCTAssertEqual(stack.peek, i)
        }
        
        for i in stride(from: 2, through: 0, by: -1) {
            XCTAssertEqual(stack.peek, i)
            XCTAssertEqual(stack.pop(), i)
            XCTAssertEqual(stack.count, i)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class DoublyLinkedListStackTests: XCTestCase {
    typealias TestType = Int
    var stack: ADL_Stack_DoublyLinkedList<TestType>!
    
    override func setUp() {
        stack = ADL_Stack_DoublyLinkedList<TestType>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_stackInitialization() {
        XCTAssertTrue(stack.isEmpty)
        XCTAssertEqual(stack.count, 0)
        XCTAssertNil(stack.peek)
        XCTAssertNil(stack.pop())
    }
    
    func test_stackPush() {
        for i in 0 ..< 3 {
            stack.push(i)
            XCTAssertFalse(stack.isEmpty)
            XCTAssertEqual(stack.peek, i)
            XCTAssertEqual(stack.count, i+1)
        }
    }
    
    func test_stackPop() {
        XCTAssertNil(stack.pop())
        for i in 0 ..< 3 {
            stack.push(i)
            XCTAssertEqual(stack.peek, i)
        }
        
        for i in stride(from: 2, through: 0, by: -1) {
            XCTAssertEqual(stack.peek, i)
            XCTAssertEqual(stack.pop(), i)
            XCTAssertEqual(stack.count, i)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


class ArrayStackTests: XCTestCase {
    typealias TestType = Int
    var stack: ADL_Stack_Array<TestType>!
    
    override func setUp() {
        stack = ADL_Stack_Array<TestType>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_stackInitialization() {
        XCTAssertTrue(stack.isEmpty)
        XCTAssertEqual(stack.count, 0)
        XCTAssertNil(stack.peek)
        XCTAssertNil(stack.pop())
//        expectFatalError(expectedMessage: "Can't remove last element from an empty collection") {
//            self.stack.pop()
//        }
    }
    
    func test_stackPush() {
        for i in 0 ..< 3 {
            stack.push(i)
            XCTAssertFalse(stack.isEmpty)
            XCTAssertEqual(stack.peek, i)
            XCTAssertEqual(stack.count, i+1)
        }
    }
    
    func test_stackPop() {
        XCTAssertNil(stack.pop())
        for i in 0 ..< 3 {
            stack.push(i)
            XCTAssertEqual(stack.peek, i)
        }
        
        for i in stride(from: 2, through: 0, by: -1) {
            XCTAssertEqual(stack.peek, i)
            XCTAssertEqual(stack.pop(), i)
            XCTAssertEqual(stack.count, i)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
