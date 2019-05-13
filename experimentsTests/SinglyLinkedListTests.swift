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
    var list: ADL_SinglyLinkList<TestType>!
    var iter: ADL_SinglyLinkList<TestType>.Iterator!

    
    override func setUp() {
        list = ADL_SinglyLinkList<TestType>()
    }

    override func tearDown() {
        list = nil
    }

    func testEmptyList() {
        XCTAssertEqual(list.count, 0)
        XCTAssertNil(list.first)
        XCTAssertNil(list.head)
        XCTAssertTrue(list.isEmpty)
        XCTAssert(list == [])
    }
//    
//    func testListInsertOutOfBounds() {
//        expectPreconditionFailure(expectedMessage: "index out of bounds") {
//            self.list.insert(1, at: 1)
//        }
//    }

    func testListInsertAtIndex() {
        list.insert(2, at: 0)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.head, 2)
        XCTAssertEqual(list[0], 2)
        XCTAssert(list == [2])
        
        list.insert(0, at: 0)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(list.head, 0)
        XCTAssertEqual(list[0], 0)
        XCTAssert(list == [0, 2])

        let listCount = list.count
        list.insert(4, at: listCount)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.head, 0)
        XCTAssertEqual(list[listCount], 4)
        XCTAssert(list == [0, 2, 4])
        
        list.insert(1, at: 1)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 4)
        XCTAssertEqual(list.head, 0)
        XCTAssertEqual(list[1], 1)
        XCTAssert(list == [0, 1, 2, 4])

        list.insert(3, at: 3)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 5)
        XCTAssertEqual(list.head, 0)
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
        }
    }
    
//    func testListRemoveOutOfBounds() {
//        expectPreconditionFailure(expectedMessage: "index out of bounds") {
//            self.list.remove(at: 1)
//        }
//    }

    func testListRemove() {
        for i in 0 ... 5 {
            list.append(i)
        }
        
        list.remove(at: list.count-1)
        XCTAssertEqual(list.count, 5)
        XCTAssert(list == [0, 1, 2, 3, 4])
        XCTAssertEqual(list.head, 0)
        XCTAssertEqual(list[list.count-1], 4)
        
        list.remove(at: 2)
        XCTAssert(list == [0, 1, 3, 4])
        XCTAssertEqual(list.head, 0)
        XCTAssertEqual(list[2], 3)

        list.remove(at: 0)
        XCTAssert(list == [1, 3, 4])
        XCTAssertEqual(list.head, 1)
        XCTAssertEqual(list[0], 1)
    }
    
    func testListIterator() {
        for i in 0 ... 5 {
            list.append(i)
        }

        for (i, value) in list.enumerated() {
            XCTAssertEqual(value, i)
        }
    }

    func testListHeadAndTail() {
        list.append(0)
        list.append(1)
        list.append(2)
        
        XCTAssertEqual(list.head, 0)
        let newList = list.tail!
        XCTAssert(newList == [1,2])
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
