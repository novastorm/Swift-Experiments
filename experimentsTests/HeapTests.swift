//
//  HeapTests.swift
//  experimentsTests
//
//  Created by Bahlreighn on 7/8/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest
@testable import experiments

class HeapTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var pq = TaskPriorityQueue()
        
        pq.push(Task(priority: 3, name: "Clear drains"))
        pq.push(Task(priority: 4, name: "Feed cat"))
        pq.push(Task(priority: 5, name: "Make tea"))
        pq.push(Task(priority: 1, name: "Solve RC tasks"))
        pq.push(Task(priority: 2, name: "Tax return"))
        
        print(pq.count)
        
        print(pq.peek())
        
        while pq.count != 0 {
            print(pq.pop())
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
