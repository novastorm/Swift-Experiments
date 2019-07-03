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
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 0)
        XCTAssertTrue(ADL_SinglyLinkedList.isEmpty(list))
    }

    func testInsertOutOfBounds() {
//        Precondition failed: Array index is out of range
//        ADL_SinglyLinkedList.insert(&list, 1, at: 1)
    }

    func testInsertAtIndex() {
        let node2 = ADL_SinglyLinkedList<TestType>(2)
        ADL_SinglyLinkedList.insert(&list, node2, at: 0)
        XCTAssertFalse(ADL_SinglyLinkedList.isEmpty(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 1)
        XCTAssertEqual(list.value, 2)
        XCTAssertEqual(list.get(at: 0).value, 2)
        XCTAssert(list == [2])
        
        let node0 = ADL_SinglyLinkedList<TestType>(0)
        ADL_SinglyLinkedList.insert(&list, node0, at: 0)
        XCTAssertFalse(ADL_SinglyLinkedList.isEmpty(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 2)
        XCTAssertEqual(list.value, 0)
        XCTAssertEqual(list.get(at: 0).value, 0)
        XCTAssert(list == [0, 2])

        let node4 = ADL_SinglyLinkedList<TestType>(4)
        let listCount = list.count
        ADL_SinglyLinkedList.insert(&list, node4, at: listCount)
        XCTAssertFalse(ADL_SinglyLinkedList.isEmpty(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 3)
        XCTAssertEqual(list.value, 0)
        XCTAssertEqual(list.get(at: listCount).value, 4)
        XCTAssert(list == [0, 2, 4])
        
        let node1 = ADL_SinglyLinkedList<TestType>(1)
        ADL_SinglyLinkedList.insert(&list, node1, at: 1)
        XCTAssertFalse(ADL_SinglyLinkedList.isEmpty(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 4)
        XCTAssertEqual(list.value, 0)
        XCTAssertEqual(list.get(at: 1).value, 1)
        XCTAssert(list == [0, 1, 2, 4])

        let node3 = ADL_SinglyLinkedList<TestType>(3)
        ADL_SinglyLinkedList.insert(&list, node3, at: 3)
        XCTAssertFalse(ADL_SinglyLinkedList.isEmpty(list))
        XCTAssertEqual(ADL_SinglyLinkedList.count(list), 5)
        XCTAssertEqual(list.value, 0)
        XCTAssertEqual(list.get(at: 3).value, 3)
        XCTAssert(list == [0, 1, 2, 3, 4])
    }

    func testAppend() {
        let start = 0
        let end = 2

        for i in start ... end {
            let node = ADL_SinglyLinkedList(i)
            ADL_SinglyLinkedList.append(&list, node)
            XCTAssertEqual(ADL_SinglyLinkedList.count(list), i+1)
            XCTAssertEqual(list.count, i+1)
            XCTAssertEqual(list.get(at: list.count-1).value, i)
            XCTAssertEqual(list.value, start)
        }
    }
    
    func testUpdate() {
        for i in 0 ..< 5 {
            let node = ADL_SinglyLinkedList(i)
            ADL_SinglyLinkedList.append(&list, node)
        }
        
        var node = list.get(at: 0)
        node.value = 10
        XCTAssertEqual(list.count, 5)
        XCTAssert(list == [10, 1, 2, 3, 4])
        XCTAssertEqual(list.value, 10)
        XCTAssertEqual(list.get(at: 0).value, 10)
        
        node = list.get(at: 2)
        node.value = 12
        XCTAssertEqual(list.count, 5)
        XCTAssert(list == [10, 1, 12, 3, 4])
        XCTAssertEqual(list.value, 10)
        XCTAssertEqual(list.get(at: 2).value, 12)
        
        node = list.get(at: 4)
        node.value = 14
        XCTAssertEqual(list.count, 5)
        XCTAssert(list == [10, 1, 12, 3, 14])
        XCTAssertEqual(list.value, 10)
        XCTAssertEqual(list.get(at: 4).value, 14)
    }

    func testRemoveOutOfBounds() {
//        Precondition failed: Array index is out of range
//        ADL_SinglyLinkedList.remove(&list, at: 1)
    }

    func testRemove() {
        for i in 0 ... 5 {
            let node = ADL_SinglyLinkedList(i)
            ADL_SinglyLinkedList.append(&list, node)
        }
        
        ADL_SinglyLinkedList.remove(&list, at: list.count-1)
        XCTAssertEqual(list.count, 5)
        XCTAssert(list == [0, 1, 2, 3, 4])
        XCTAssertEqual(list.value, 0)
        XCTAssertEqual(list.get(at: list.count-1).value, 4)
        
        ADL_SinglyLinkedList.remove(&list, at: 2)
        XCTAssertEqual(list.count, 4)
        XCTAssert(list == [0, 1, 3, 4])
        XCTAssertEqual(list.value, 0)
        XCTAssertEqual(list.get(at: 2).value, 3)

        ADL_SinglyLinkedList.remove(&list, at: 0)
        XCTAssertEqual(list.count, 3)
        XCTAssert(list == [1, 3, 4])
        XCTAssertEqual(list.value, 1)
        XCTAssertEqual(list.get(at: 0).value, 1)
    }
    
    func testIterator() {
        for i in 0 ... 5 {
            let node = ADL_SinglyLinkedList(i)
            ADL_SinglyLinkedList.append(&list, node)
        }

        for (i, node) in list.enumerated() {
            XCTAssertEqual(node.value, i)
        }
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
