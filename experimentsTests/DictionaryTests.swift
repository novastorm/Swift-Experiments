//
//  DictionaryTests.swift
//  experimentsTests
//
//  Created by Bahlreighn on 7/18/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest
@testable import experiments

class DictionaryTests: XCTestCase {

    typealias Key = String
    typealias Value = String
    var dict: ADL_Dictionary<Key, Value>!
    
    override func setUp() {
        dict = ADL_Dictionary<Key, Value>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        print(dict.capacity)
        print(dict.count)
        print()
        
        dict.updateValue("AAA", forKey: "aaa")
        print(dict.capacity)
        print(dict.count)
        print(dict.getValue(forKey: "aaa"))
        
        dict.updateValue("BBB", forKey: "bbb")
        print(dict.capacity)
        print(dict.count)
        print(dict.getValue(forKey: "bbb"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
