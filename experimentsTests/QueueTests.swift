//
//  StackTests.swift
//  experimentsTests
//
//  Created by Bahlreighn on 5/11/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest
@testable import experiments


class BaseQueueTests: XCTestCase {
    typealias TestType = Int
    var queue: ADL_AnyQueue<TestType>!
    
    override func setUp() {
        _abstract()
    }
    
    func test_queueInitialization() {
        XCTAssertTrue(queue.isEmpty)
        XCTAssertEqual(queue.count, 0)
        XCTAssertNil(queue.peek)
    }
    
    func test_queueEnqueue() {
        queue.enqueue(0)
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 1)
        XCTAssertEqual(queue.peek, 0)

        queue.enqueue(1)
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 2)
        XCTAssertEqual(queue.peek, 0)

        queue.enqueue(2)
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 3)
        XCTAssertEqual(queue.peek, 0)
    }
    
    func test_queueDequeue() {
        XCTAssertNil(queue.dequeue())
        for i in 0 ..< 3 {
            queue.enqueue(i)
        }
        XCTAssertEqual(queue.peek, 0)
        XCTAssertEqual(queue.dequeue(), 0)
        XCTAssertEqual(queue.count, 2)

        XCTAssertEqual(queue.peek, 1)
        XCTAssertEqual(queue.dequeue(), 1)
        XCTAssertEqual(queue.count, 1)

        XCTAssertEqual(queue.peek, 2)
        XCTAssertEqual(queue.dequeue(), 2)
        XCTAssertEqual(queue.count, 0)

        XCTAssertNil(queue.peek)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class SinglyLinkedListQueueTests: BaseQueueTests {
    override func setUp() {
        queue = ADL_AnyQueue(ADL_Queue_SinglyLinkedList<TestType>())
    }
}

class DoublyLinkedListQueueTests: BaseQueueTests {
    override func setUp() {
        queue = ADL_AnyQueue(ADL_Queue_DoublyLinkedList<TestType>())
    }
}

class ADLArrayQueueTests: BaseQueueTests {
    override func setUp() {
        queue = ADL_AnyQueue(ADL_Queue_ADL_Array<TestType>())
    }
}

class ArrayQueueTests: BaseQueueTests {
    override func setUp() {
        queue = ADL_AnyQueue(ADL_Queue_Array<TestType>())
    }
}
