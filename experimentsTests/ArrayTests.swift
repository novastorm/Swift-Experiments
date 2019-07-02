//
//  ArrayTests.swift
//  experimentsTests
//
//  Created by Bahlreighn on 5/10/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest
@testable import experiments

class ArrayTests: XCTestCase {

    typealias TestType = Int
    var array: ADL_Array<TestType>!
    
    override func setUp() {
        array = ADL_Array<TestType>()
    }
    
    func test_newArray() {
        XCTAssertTrue(array.isEmpty)
        XCTAssertEqual(array.capacity, 0)
        XCTAssertEqual(array.count, 0)
        XCTAssertNil(array.first)
        XCTAssertNil(array.last)
    }

    func test_arrayInsertOutOfBounds() {
//        Precondition failed: Array index is out of range
//        array.insert(1, at: 1)
    }
    
    func test_arrayInsert() {
        self.array.insert(0, at: 0)
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 1)
        XCTAssertEqual(array.count, 1)
        XCTAssertEqual(array.first, 0)
        XCTAssertEqual(array.last, 0)
        XCTAssertEqual(array[0], 0)
        XCTAssert(array == [0])

        array.insert(1, at: 1)
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 3)
        XCTAssertEqual(array.count, 2)
        XCTAssertEqual(array.first, 0)
        XCTAssertEqual(array.last, 1)
        XCTAssertEqual(array[1], 1)
        XCTAssert(array == [0,1])

        array.insert(2, at: 2)
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 3)
        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array.first, 0)
        XCTAssertEqual(array.last, 2)
        XCTAssertEqual(array[2], 2)
        XCTAssert(array == [0,1,2])

        array.insert(3, at: 3)
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 6)
        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(array.first, 0)
        XCTAssertEqual(array.last, 3)
        XCTAssertEqual(array[3], 3)
        XCTAssert(array == [0,1,2,3])

    }
    
    func test_arrayAppend() {
        let start = 0
        let end = 4
        for i in start ... end {
            array.append(i)
            XCTAssertEqual(array[array.count-1], i)
            XCTAssertEqual(array.first, start)
            XCTAssertEqual(array.last, i)
        }

        XCTAssert(array == [0,1,2,3,4])
    }
        
    func test_arrayRemovalOutOfBounds() {
//        Precondition failed: Array index is out of range
//        array.remove(at: 1)
//        Precondition failed: Can't remove last element from an empty collection
//        array.removeLast()
//        Fatal error: Can't remove last element from an empty collection
    }

    func test_arrayRemoval() {
        for i in 0 ..< 5 {
            array.append(i)
        }
        
        array.remove(at: 2)
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 6)
        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(array.first, 0)
        XCTAssertEqual(array.last, 4)
        XCTAssertEqual(array[0], 0)
        XCTAssertEqual(array[1], 1)
        XCTAssertEqual(array[2], 3)
        XCTAssertEqual(array[3], 4)
        XCTAssert(array == [0,1,3,4])
        
        array.remove(at: 0)
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 6)
        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array.first, 1)
        XCTAssertEqual(array.last, 4)
        XCTAssertEqual(array[0], 1)
        XCTAssertEqual(array[1], 3)
        XCTAssertEqual(array[2], 4)
        XCTAssert(array == [1,3,4])

        array.removeLast()
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 6)
        XCTAssertEqual(array.count, 2)
        XCTAssertEqual(array.first, 1)
        XCTAssertEqual(array.last, 3)
        XCTAssertEqual(array[0], 1)
        XCTAssertEqual(array[1], 3)
        XCTAssert(array == [1,3])
    }
    
    func test_arrayIterator() {
        for i in 0 ..< 5 {
            array.append(i)
        }
        
        for (i, value) in array.enumerated() {
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
