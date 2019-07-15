//
//  BubbleSortTests.swift
//  experimentsTests
//
//  Created by Bahlreighn on 7/14/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest
@testable import experiments

class BubbleSortTests: XCTestCase {

    func testBubbleSortBruteForce() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let array = [6, 5, 3, 1, 8, 7, 2, 4]
        var bruteForce = array
        print(bruteForce.bubbleSortBackToFront())
        print(bruteForce)
        
        var swapCheck = array
        print(swapCheck.bubbleSortBackToFrontSwapCheck())
        print(swapCheck)
        
        var swapCheckEfficient = array
        print(swapCheckEfficient.bubbleSortBackToFrontSwapCheckEfficient())
        print(swapCheckEfficient)

        var frontToBack = array
        print(frontToBack.bubbleSortFrontToBack())
        print(frontToBack)

        var frontToBackSwapCheck = array
        print(frontToBackSwapCheck.bubbleSortFrontToBackSwapCheck())
        print(frontToBackSwapCheck)

        var frontToBackSwapCheckEfficient = array
        print(frontToBackSwapCheckEfficient.bubbleSortFrontToBackSwapCheckEfficient())
        print(frontToBackSwapCheckEfficient)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
