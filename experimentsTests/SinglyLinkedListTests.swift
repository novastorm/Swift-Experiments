//
//  experimentsTests.swift
//  experimentsTests
//
//  Created by Bahlreighn on 5/4/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest
@testable import experiments

class SinglyLinkedListTests: XCTestCase {
    
    typealias TestType = Int
    var list: ADL_SinglyLinkedList<TestType>!
    var iter: ADL_SinglyLinkedList<TestType>.Iterator!

    override func setUp() {
        list = nil
    }

    override func tearDown() {
        list = nil
    }

    func testEmptyList() {
        XCTAssertNil(ADL_SinglyLinkedList.head(list))
        XCTAssertNil(ADL_SinglyLinkedList.tail(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 0)
        XCTAssertTrue(ADL_SinglyLinkedList.isEmpty(list))
    }

    func testInsertOutOfBounds() {
//        Precondition failed: Array index is out of range
//        ADL_SinglyLinkedList.insert(&list, 1, at: 1)
    }

    func testInsertAtIndex() {
        ADL_SinglyLinkedList.insert(&list, 2, at: 0)
        XCTAssertFalse(ADL_SinglyLinkedList.isEmpty(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 1)
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 2)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: 0), 2)
        XCTAssert(list == [2])
        
        ADL_SinglyLinkedList.insert(&list, 0, at: 0)
        XCTAssertFalse(ADL_SinglyLinkedList.isEmpty(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 2)
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 0)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: 0), 0)
        XCTAssert(list == [0, 2])

        let listCount = list.count
        ADL_SinglyLinkedList.insert(&list, 4, at: listCount)
        XCTAssertFalse(ADL_SinglyLinkedList.isEmpty(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 3)
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 0)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: listCount), 4)
        XCTAssert(list == [0, 2, 4])
        
        ADL_SinglyLinkedList.insert(&list, 1, at: 1)
        XCTAssertFalse(ADL_SinglyLinkedList.isEmpty(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 4)
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 0)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: 1), 1)
        XCTAssert(list == [0, 1, 2, 4])

        ADL_SinglyLinkedList.insert(&list, 3, at: 3)
        XCTAssertFalse(ADL_SinglyLinkedList.isEmpty(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 5)
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 0)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: 3), 3)
        XCTAssert(list == [0, 1, 2, 3, 4])
    }

    func testAppend() {
        let start = 0
        let end = 2

        for i in start ... end {
//            list.append(i)
            ADL_SinglyLinkedList.append(&list, i)
            XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: list.count-1), i)
            XCTAssertEqual(list.head, start)
        }
    }
    
    func testUpdateOutOfBounds() {
//        Precondition failed: Array index is out of range
//        ADL_SinglyLinkedList.update(list, value: 1, at: 1)
        
//        for i in 0 ..< 5 {
//            ADL_SinglyLinkedList.append(&list, i)
//        }
//        Precondition failed: Array index is out of range
//        ADL_SinglyLinkedList.update(list, value: -1, at: -1)
//        Precondition failed: Array index is out of range
//        ADL_SinglyLinkedList.update(list, value: 5, at: 5)
    }
    
    func testUpdate() {
        for i in 0 ..< 5 {
            ADL_SinglyLinkedList.append(&list, i)
        }
        
        ADL_SinglyLinkedList.update(list, value: 10, at: 0)
        XCTAssertEqual(list.count, 5)
        XCTAssert(list == [10, 1, 2, 3, 4])
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 10)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: 0), 10)
        
        ADL_SinglyLinkedList.update(list, value: 12, at: 2)
        XCTAssertEqual(list.count, 5)
        XCTAssert(list == [10, 1, 12, 3, 4])
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 10)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: 2), 12)
        
        ADL_SinglyLinkedList.update(list, value: 14, at: 4)
        XCTAssertEqual(list.count, 5)
        XCTAssert(list == [10, 1, 12, 3, 14])
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 10)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: 4), 14)
    }

    func testRemoveOutOfBounds() {
//        Precondition failed: Array index is out of range
//        ADL_SinglyLinkedList.remove(&list, at: 1)
    }

    func testRemove() {
        for i in 0 ... 5 {
            ADL_SinglyLinkedList.append(&list, i)
        }
        
        ADL_SinglyLinkedList.remove(&list, at: list.count-1)
        XCTAssertEqual(list.count, 5)
        XCTAssert(list == [0, 1, 2, 3, 4])
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 0)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: list.count-1), 4)
        
        ADL_SinglyLinkedList.remove(&list, at: 2)
        XCTAssert(list == [0, 1, 3, 4])
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 0)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: 2), 3)

        ADL_SinglyLinkedList.remove(&list, at: 0)
        XCTAssert(list == [1, 3, 4])
        XCTAssertEqual(ADL_SinglyLinkedList.head(list), 1)
        XCTAssertEqual(ADL_SinglyLinkedList.get(list, at: 0), 1)
    }
    
    func testIterator() {
        for i in 0 ... 5 {
            ADL_SinglyLinkedList.append(&list, i)
        }

        for (i, value) in list.enumerated() {
            XCTAssertEqual(value, i)
        }
    }

    func testHeadAndTail() {
        for i in 0 ... 2 {
            ADL_SinglyLinkedList.append(&list, i)
        }

        XCTAssertEqual(list.head, 0)
        XCTAssert(list.tail! == [1,2])
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
