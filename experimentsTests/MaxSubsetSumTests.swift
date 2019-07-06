//
//  MaxSubsetSumTests.swift
//  experimentsTests
//
//  Created by Bahlreighn on 7/4/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest
@testable import experiments


class MaxSubsetSumTests: XCTestCase {

    let testCases = [
        [-5, -5, -5, 10, -5]: 5,
        [-5, 10, -5, -5, -5]: 5,
        [-5, -5, -5, -5, -5]: -10,
        [3, 5, -7, 8, 10]: 15,
        
        [3, 1, -2, -4, 5]: 8,
        [-2, 1, 3, -4, 5]: 8,
        [5, -4, -2, 1, 3]: 8,
        [5, -4, 3, 1, -2]: 8,
        
        [3, 1, 2, 4, 5]: 10,
        [2, 1, 3, 4, 5]: 10,
        [5, 4, 2, 1, 3]: 10,
        [5, 4, 3, 1, 2]: 10
    ]

//    func test() {
//        for (array, result) in testCases {
//            XCTAssertEqual(MaxSubsetSum.test(array), result, "\(array)")
//        }
//    }

    func testRecursiveBottomUp() {
        for (array, result) in testCases {
            XCTAssertEqual(MaxSubsetSum.recursiveBottomUp(array), result, "\(array)")
        }
    }

    func testRecursiveBottomUpIndexed() {
        for (array, result) in testCases {
            XCTAssertEqual(MaxSubsetSum.recursiveBottomUpIndexed(array), result)
        }
    }

    func testRecursiveBottomUpIndexedMemoized() {
        for (array, result) in testCases {
            XCTAssertEqual(MaxSubsetSum.recursiveBottomUpIndexedMemoized(array), result)
        }
    }

    func testRecursiveTopDown() {
        for (array, result) in testCases {
            XCTAssertEqual(MaxSubsetSum.recursiveTopDown(array), result, "\(array)")
        }
    }

    func testRecursiveTopDownIndexed() {
        for (array, result) in testCases {
            XCTAssertEqual(MaxSubsetSum.recursiveTopDownIndexed(array), result, "\(array)")
        }
    }

    func testRecursiveTopDownIndexedMemoized() {
        for (array, result) in testCases {
            XCTAssertEqual(MaxSubsetSum.recursiveTopDownIndexedMemoized(array), result, "\(array)")
        }
    }

    func testIterativeTopDownIndexedMemoized() {
        for (array, result) in testCases {
            XCTAssertEqual(MaxSubsetSum.iterativeTopDownIndexedMemoized(array), result)
        }
    }

    func testIterativeTopDownIndexedInPlace() {
        for (array, result) in testCases {
            var array = array
            XCTAssertEqual(MaxSubsetSum.iterativeTopDownIndexedInPlace(&array), result)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
