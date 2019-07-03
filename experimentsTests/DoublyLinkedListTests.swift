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
        list = nil
    }

    override func tearDown() {
        list = nil
    }

    func testEmptyList() {
        XCTAssertEqual(ADL_DoublyLinkedList.count(list), 0)
        XCTAssertTrue(ADL_DoublyLinkedList.isEmpty(list))
        XCTAssertNil(list?.startNode)
        XCTAssertNil(list?.endNode)
    }

    func testInsertOutOfBounds() {
//        Precondition failed: DoublyLinkedList index is out of range
//        let node1 = ADL_DoublyLinkedList(1)
//        ADL_DoublyLinkedList.insert(&list, node1, at: 1)
    }

    func testInsert() {
        
        let node2 = ADL_DoublyLinkedList<TestType>(2)
        ADL_DoublyLinkedList.insert(&list, node2, at: 0)
        XCTAssertEqual(ADL_DoublyLinkedList.count(list), 1)
        XCTAssertFalse(ADL_DoublyLinkedList.isEmpty(list))
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.startNode?.value, 2)
        XCTAssertEqual(list.endNode?.value, 2)
        XCTAssertEqual(list.get(at: 0).value, 2)
        XCTAssert(list == [2])

        let node0 = ADL_DoublyLinkedList(0)
        ADL_DoublyLinkedList.insert(&list, node0, at: 0)
        XCTAssertEqual(ADL_DoublyLinkedList.count(list), 2)
        XCTAssertFalse(ADL_DoublyLinkedList.isEmpty(list))
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(list.startNode?.value, 0)
        XCTAssertEqual(list.endNode?.value, 2)
        XCTAssertEqual(list.get(at:0).value, 0)
        XCTAssert(list == [0, 2])

        let node4 = ADL_DoublyLinkedList(4)
        let listCount = list.count
        ADL_DoublyLinkedList.insert(&list, node4, at: listCount)
        XCTAssertEqual(ADL_DoublyLinkedList.count(list), 3)
        XCTAssertFalse(ADL_DoublyLinkedList.isEmpty(list))
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.startNode?.value, 0)
        XCTAssertEqual(list.endNode?.value, 4)
        XCTAssertEqual(list.get(at: listCount).value, 4)
        XCTAssert(list == [0, 2, 4])

        let node1 = ADL_DoublyLinkedList(1)
        ADL_DoublyLinkedList.insert(&list, node1, at: 1)
        XCTAssertEqual(ADL_DoublyLinkedList.count(list), 4)
        XCTAssertFalse(ADL_DoublyLinkedList.isEmpty(list))
        XCTAssertEqual(list.count, 4)
        XCTAssertEqual(list.startNode?.value, 0)
        XCTAssertEqual(list.endNode?.value, 4)
        XCTAssertEqual(list.get(at:1).value, 1)
        XCTAssert(list == [0, 1, 2, 4])

        let node3 = ADL_DoublyLinkedList(3)
        ADL_DoublyLinkedList.insert(&list, node3, at: 3)
        XCTAssertEqual(ADL_DoublyLinkedList.count(list), 5)
        XCTAssertFalse(ADL_DoublyLinkedList.isEmpty(list))
        XCTAssertEqual(list.count, 5)
        XCTAssertEqual(list.startNode?.value, 0)
        XCTAssertEqual(list.endNode?.value, 4)
        XCTAssertEqual(list.get(at:3).value, 3)
        XCTAssert(list == [0, 1, 2, 3, 4])
    }

    func testListAppend() {
        let start = 0
        let end = 2

        for i in start ... end {
            let node = ADL_DoublyLinkedList(i)
            ADL_DoublyLinkedList.append(&list, node)
            XCTAssertEqual(ADL_DoublyLinkedList.count(list), i+1)
            XCTAssertEqual(list.count, i+1)
            XCTAssertEqual(list.get(at: list.count-1).value, i)
            XCTAssertEqual(list.startNode?.value, start)
            XCTAssertEqual(list.endNode?.value, i)
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
            let node = ADL_DoublyLinkedList(i)
            ADL_DoublyLinkedList.append(&list, node)
        }

        ADL_DoublyLinkedList.removeLast(&list)
        XCTAssert(list == [0, 1, 2, 3, 4])
        XCTAssertEqual(list.startNode?.value, 0)
        XCTAssertEqual(list.endNode?.value, 4)


        ADL_DoublyLinkedList.remove(&list, at: 2)
        XCTAssert(list == [0, 1, 3, 4])
        XCTAssertEqual(list.startNode?.value, 0)
        XCTAssertEqual(list.endNode?.value, 4)

        ADL_DoublyLinkedList.remove(&list, at: 0)
        XCTAssert(list == [1, 3, 4])
        XCTAssertEqual(list.startNode?.value, 1)
        XCTAssertEqual(list.endNode?.value, 4)
    }
    
    func testListIterator() {
        for i in 0 ... 5 {
            let node = ADL_DoublyLinkedList(i)
            ADL_DoublyLinkedList.append(&list, node)
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
