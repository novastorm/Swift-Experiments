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
        ["input": [-5, -5, -5, 10, -5], "result": 5],
        ["input": [-5, 10, -5, -5, -5], "result": 5],
        ["input": [-5, -5, -5, -5, -5], "result": -10],
        ["input": [3, 5, -7, 8, 10], "result": 15],
        
        ["input": [3, 1, -2, -4, 5], "result": 8],
        ["input": [-2, 1, 3, -4, 5], "result": 8],
        ["input": [5, -4, -2, 1, 3], "result": 8],
        ["input": [5, -4, 3, 1, -2], "result": 8],
        
        ["input": [3, 1, 2, 4, 5], "result": 10],
        ["input": [2, 1, 3, 4, 5], "result": 10],
        ["input": [5, 4, 2, 1, 3], "result": 10],
        ["input": [5, 4, 3, 1, 2], "result": 10]
    ]

//    func test() {
//        for (array, result) in testCases {
//            XCTAssertEqual(MaxSubsetSum.test(array), result, "\(array)")
//        }
//    }

    func testRecursiveBottomUp() {
        for test in testCases {
            let array = test["input"] as! [Int]
            let result = test["result"] as! Int
            XCTAssertEqual(MaxSubsetSum.recursiveBottomUp(array), result, "\(array)")
        }
    }

    func testRecursiveBottomUpIndexed() {
        for test in testCases {
            let array = test["input"] as! [Int]
            let result = test["result"] as! Int
            XCTAssertEqual(MaxSubsetSum.recursiveBottomUpIndexed(array), result)
        }
    }

    func testRecursiveBottomUpIndexedMemoized() {
        for test in testCases {
            let array = test["input"] as! [Int]
            let result = test["result"] as! Int
            XCTAssertEqual(MaxSubsetSum.recursiveBottomUpIndexedMemoized(array), result)
        }
    }

    func testRecursiveTopDown() {
        for test in testCases {
            let array = test["input"] as! [Int]
            let result = test["result"] as! Int
            XCTAssertEqual(MaxSubsetSum.recursiveTopDown(array), result, "\(array)")
        }
    }

    func testRecursiveTopDownIndexed() {
        for test in testCases {
            let array = test["input"] as! [Int]
            let result = test["result"] as! Int
            XCTAssertEqual(MaxSubsetSum.recursiveTopDownIndexed(array), result, "\(array)")
        }
    }

    func testRecursiveTopDownIndexedMemoized() {
        for test in testCases {
            let array = test["input"] as! [Int]
            let result = test["result"] as! Int
            XCTAssertEqual(MaxSubsetSum.recursiveTopDownIndexedMemoized(array), result, "\(array)")
        }
    }

    func testIterativeTopDownIndexedMemoized() {
        for test in testCases {
            let array = test["input"] as! [Int]
            let result = test["result"] as! Int
            XCTAssertEqual(MaxSubsetSum.iterativeTopDownIndexedMemoized(array), result)
        }
    }

    func testIterativeTopDownSpaceEfficient() {
        for test in testCases {
            let array = test["input"] as! [Int]
            let result = test["result"] as! Int
            XCTAssertEqual(MaxSubsetSum.iterativeTopDownSpaceEfficient(array), result)
        }
    }

//    func test_2() {
//        for test in testCases {
//            let array = test["input"] as! [Int]
//            let result = test["result"] as! Int
//            XCTAssertEqual(MaxSubsetSum.test_2(array), result)
//        }
//    }

//    func test_3() {
//        for test in testCases {
//            let array = test["input"] as! [Int]
//            let result = test["result"] as! Int
//            XCTAssertEqual(MaxSubsetSum.test_3(array), result)
//        }
//    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
//            MaxSubsetSum.iterativeTopDownSpaceEfficient(testCases[1])
        }
    }

}
