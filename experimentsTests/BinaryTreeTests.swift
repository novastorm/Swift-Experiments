//
//  BinaryTreeTests.swift
//  experimentsTests
//
//  Created by Bahlreighn on 5/11/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import XCTest
@testable import experiments


class BinaryTreeTests: XCTestCase {
    typealias TestType = Int
    var root: ADL_BinaryTree<TestType>!
    
    override func setUp() {
        root = nil
    }

    override func tearDown() {
        root = nil
    }

    func test_NodeInitialization() {
        let node = ADL_BinaryTree(0)
        XCTAssertNotNil(node)
        XCTAssertEqual(node.value, 0)
        XCTAssertNil(node.left)
        XCTAssertNil(node.right)
    }
    
    func test_TreeTraversal() {
        let node0 = ADL_BinaryTree(0)
        let node1 = ADL_BinaryTree(1)
        let node2 = ADL_BinaryTree(2)
        let node3 = ADL_BinaryTree(3)
        let node4 = ADL_BinaryTree(4)
        let node5 = ADL_BinaryTree(5)
        
        let root = node4
        node4.left = node2
        node4.right = node5
        node2.left = node1
        node2.right = node3
        node1.left = node0
        
        var result = [Int]()
        root.traverseBreadthFirst { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [4,2,5,1,3,0])
        
        result.removeAll(keepingCapacity: true)
        root.traversePreOrder { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [4,2,1,0,3,5])

        result.removeAll(keepingCapacity: true)
        root.traverseInOrder { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [0,1,2,3,4,5])
        
        result.removeAll(keepingCapacity: true)
        root.traversePostOrder { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [0,1,3,2,5,4])
        
        result.removeAll(keepingCapacity: true)
        root.traverseOutOrder { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [5,4,3,2,1,0])
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
