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
    var array: ADL_ArrayImplementation<TestType>!
    
    override func setUp() {
        array = ADL_ArrayImplementation<TestType>()
    }
    
    func test_newArray() {
        XCTAssertTrue(array.isEmpty)
        XCTAssertEqual(array.capacity, 0)
        XCTAssertEqual(array.count, 0)
        XCTAssertNil(array.first)
        XCTAssertNil(array.last)
    }
    
    func test_arrayInsertion() {
//        array.insert(1, at: 1)
        array.insert(0, at: 0)
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 1)
        XCTAssertEqual(array.count, 1)
        XCTAssertEqual(array.first, 0)
        XCTAssertEqual(array.last, 0)
        XCTAssertEqual(array[0], 0)

        array.insert(1, at: 1)
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 3)
        XCTAssertEqual(array.count, 2)
        XCTAssertEqual(array.first, 0)
        XCTAssertEqual(array.last, 1)
        XCTAssertEqual(array[0], 0)
        XCTAssertEqual(array[1], 1)
        
        array[2] = 2
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 3)
        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array.first, 0)
        XCTAssertEqual(array.last, 2)
        XCTAssertEqual(array[0], 0)
        XCTAssertEqual(array[1], 1)
        XCTAssertEqual(array[2], 2)
        
        array[3] = 3
        XCTAssertFalse(array.isEmpty)
        XCTAssertEqual(array.capacity, 6)
        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(array.first, 0)
        XCTAssertEqual(array.last, 3)
        XCTAssertEqual(array[0], 0)
        XCTAssertEqual(array[1], 1)
        XCTAssertEqual(array[2], 2)
        XCTAssertEqual(array[3], 3)
    }
    
    func test_arrayAppend() {
        for i in 0 ... 4 {
            array.append(i)
        }

        XCTAssertEqual(array[0], 0)
        XCTAssertEqual(array[1], 1)
        XCTAssertEqual(array[2], 2)
        XCTAssertEqual(array[3], 3)
        XCTAssertEqual(array[4], 4)
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
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
