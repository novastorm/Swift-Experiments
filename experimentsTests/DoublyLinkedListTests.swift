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
    var list: ADL_DoublyLinkList<TestType>!
    var iter: ADL_DoublyLinkList<TestType>.Iterator!

    
    override func setUp() {
        list = ADL_DoublyLinkList<TestType>()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyList() {
        XCTAssertEqual(list.count, 0)
        XCTAssertNil(list.first)
        XCTAssertNil(list.head)
        XCTAssertTrue(list.isEmpty)
    }
    
    func testListInsertionAtIndex() {
        list.insert(2, at: 0)
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list[0], 2)
        list.insert(0, at: 0)
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(list[0], 0)
        XCTAssertEqual(list[1], 2)
        list.insert(4, at: list.count)
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list[0], 0)
        XCTAssertEqual(list[1], 2)
        XCTAssertEqual(list[2], 4)
        list.insert(1, at: 1)
        XCTAssertEqual(list.count, 4)
        XCTAssertEqual(list[0], 0)
        XCTAssertEqual(list[1], 1)
        XCTAssertEqual(list[2], 2)
        XCTAssertEqual(list[3], 4)
        list.insert(3, at: 3)
        XCTAssertEqual(list.count, 5)
        XCTAssertEqual(list[0], 0)
        XCTAssertEqual(list[1], 1)
        XCTAssertEqual(list[2], 2)
        XCTAssertEqual(list[3], 3)
        XCTAssertEqual(list[4], 4)
    }

    func testListAppend() {
        let start = 0
        let end = 2

        for i in start ... end {
            list.append(i)
            XCTAssertEqual(list[list.count-1], i)
        }
    }
    
    func testListIterator() {
        list.append(0)
        list.append(1)
        list.append(2)
        list.append(3)
        list.append(4)
        list.append(5)
        iter = list.makeIterator()!
        for i in 0 ..< list.count {
            XCTAssertEqual(iter.value, i)
            iter.next()
        }
    }
    
    func testListRemove() {
        list.append(0)
        list.append(1)
        list.append(2)
        list.append(3)
        list.append(4)
        list.append(5)
        
        list.remove(at: list.count-1)
        XCTAssertEqual(list[list.count-1], 4)
        list.remove(at: 2)
        XCTAssertEqual(list[2], 3)
        list.remove(at: 0)
        XCTAssertEqual(list[0], 1)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
