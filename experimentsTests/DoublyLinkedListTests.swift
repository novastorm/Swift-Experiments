//
//  experimentsTests.swift
//  experimentsTests
//
//  Created by Bahlreighn on 5/4/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest
@testable import experiments

class DoublyLinkedListTests: XCTestCase {
    
    typealias TestType = Int
    var list: ADL_DoublyLinkedList<TestType>!
    var iter: ADL_DoublyLinkedList<TestType>.Iterator!

    
    override func setUp() {
        list = ADL_DoublyLinkedList<TestType>()
    }

    override func tearDown() {
        list = nil
    }

    func testEmptyList() {
        XCTAssertEqual(list.count, 0)
        XCTAssertTrue(list.isEmpty)
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
        XCTAssertNil(list.head)
        XCTAssert(list == [])
    }

    func test_arrayInsertOutOfBounds() {
//        Precondition failed: DoublyLinkedList index is out of range
//        self.list.insert(1, at: 1)
    }

    func testListInsert() {
        list.insert(2, at: 0)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.first, 2)
        XCTAssertEqual(list.last, 2)
        XCTAssertEqual(list[0], 2)
        XCTAssert(list == [2])

        list.insert(0, at: 0)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(list.first, 0)
        XCTAssertEqual(list.last, 2)
        XCTAssertEqual(list[0], 0)
        XCTAssert(list == [0, 2])

        let listCount = list.count
        list.insert(4, at: listCount)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.first, 0)
        XCTAssertEqual(list.last, 4)
        XCTAssertEqual(list[listCount], 4)
        XCTAssert(list == [0, 2, 4])

        list.insert(1, at: 1)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 4)
        XCTAssertEqual(list.first, 0)
        XCTAssertEqual(list.last, 4)
        XCTAssertEqual(list[1], 1)
        XCTAssert(list == [0, 1, 2, 4])

        list.insert(3, at: 3)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 5)
        XCTAssertEqual(list.first, 0)
        XCTAssertEqual(list.last, 4)
        XCTAssertEqual(list[3], 3)
        XCTAssert(list == [0, 1, 2, 3, 4])
    }

    func testListAppend() {
        let start = 0
        let end = 2

        for i in start ... end {
            list.append(i)
            XCTAssertEqual(list[list.count-1], i)
            XCTAssertEqual(list.first, start)
            XCTAssertEqual(list.last, i)
        }
    }
    
    func test_arrayRemovalOutOfBounds() {
//        Precondition failed: DoublyLinkedList index is out of range
//        self.list.remove(at: 1)
//        Precondition failed: Can't remove last element from an empty collection
//        self.list.removeLast()
    }

    func testListRemove() {
        for i in 0 ... 5 {
            list.append(i)
        }

        list.removeLast()
        XCTAssert(list == [0, 1, 2, 3, 4])
        XCTAssertEqual(list.first, 0)
        XCTAssertEqual(list.last, 4)

        list.remove(at: 2)
        XCTAssert(list == [0, 1, 3, 4])
        XCTAssertEqual(list.first, 0)
        XCTAssertEqual(list.last, 4)

        list.remove(at: 0)
        XCTAssert(list == [1, 3, 4])
        XCTAssertEqual(list.first, 1)
        XCTAssertEqual(list.last, 4)
    }
    
    func testListIterator() {
        for i in 0 ... 5 {
            list.append(i)
        }
        for (i, value) in list.enumerated() {
            XCTAssertEqual(value, i)
        }
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
