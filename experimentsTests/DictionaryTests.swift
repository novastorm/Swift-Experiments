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

    func testInitialize() {
        XCTAssertEqual(dict.capacity, 0)
        XCTAssertEqual(dict.count, 0)
        XCTAssertTrue(dict.isEmpty)
    }
 
    func testGetNonexistantKey() {
        XCTAssertNil(dict.getValue(forKey: "aaa"))
    }
    
    func testInsert() {
        XCTAssertNil(dict.updateValue("AAA", forKey: "aaa"))
        XCTAssertEqual(dict.capacity, 1)
        XCTAssertEqual(dict.count, 1)
        XCTAssertFalse(dict.isEmpty)

        XCTAssertEqual(dict.getValue(forKey: "aaa"), "AAA")

        XCTAssertNil(dict.updateValue("BBB", forKey: "bbb"))
        XCTAssertEqual(dict.capacity, 3)
        XCTAssertEqual(dict.count, 2)
        XCTAssertFalse(dict.isEmpty)
        
        XCTAssertEqual(dict.getValue(forKey: "bbb"), "BBB")

        XCTAssertNil(dict.updateValue("CCC", forKey: "ccc"))
        XCTAssertEqual(dict.capacity, 3)
        XCTAssertEqual(dict.count, 3)
        XCTAssertFalse(dict.isEmpty)
        
        XCTAssertEqual(dict.getValue(forKey: "ccc"), "CCC")

        XCTAssertNil(dict.updateValue("DDD", forKey: "ddd"))
        XCTAssertEqual(dict.capacity, 6)
        XCTAssertEqual(dict.count, 4)
        XCTAssertFalse(dict.isEmpty)
        
        XCTAssertEqual(dict.getValue(forKey: "ddd"), "DDD")
    }
    
    func testUpdate() {
        XCTAssertNil(dict.updateValue("AAA", forKey: "aaa"))

        XCTAssertEqual(dict.updateValue("AAAAAA", forKey: "aaa"), "AAA")
        XCTAssertFalse(dict.isEmpty)

        XCTAssertEqual(dict.getValue(forKey: "aaa"), "AAAAAA")
    }
    
    func testRemoveNonexistantKey() {
        XCTAssertNil(dict.removeValue(forKey: "aaa"))
    }

    func testSubscript() {
        XCTAssertNil(dict["aaa"])
        dict["aaa"] = "AAA"
        XCTAssertEqual(dict["aaa"], "AAA")
        dict["aaa"] = nil
        XCTAssertNil(dict["aaa"])
    }

    func testRemove() {
        XCTAssertNil(dict.updateValue("AAA", forKey: "aaa"))
        XCTAssertNil(dict.updateValue("BBB", forKey: "bbb"))

        XCTAssertEqual(dict.removeValue(forKey: "aaa"), "AAA")
        XCTAssertFalse(dict.isEmpty)
        XCTAssertEqual(dict.count, 1)

        XCTAssertNil(dict.getValue(forKey: "aaa"))

        XCTAssertEqual(dict.removeValue(forKey: "bbb"), "BBB")
        XCTAssertTrue(dict.isEmpty)
        XCTAssertEqual(dict.count, 0)
        
        XCTAssertNil(dict.getValue(forKey: "bbb"))

        XCTAssertNil(dict.removeValue(forKey: "bbb"), "BBB")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
