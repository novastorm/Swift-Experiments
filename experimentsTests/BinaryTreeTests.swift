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
    var root: ADL_BinaryTreeNode_Recursive<TestType>!
    
    override func setUp() {
        root = nil
    }

    override func tearDown() {
        root = nil
    }

    func test_NodeInitialization() {
        typealias Node = ADL_BinaryTreeNode_Recursive
        let node = Node(0)
        XCTAssertNotNil(node)
        XCTAssertEqual(node.value, 0)
        XCTAssertNil(node.left)
        XCTAssertNil(node.right)
    }
    
    func test_TreeTraversal() {
        typealias Node = ADL_BinaryTreeNode_Recursive
        
        let node5 = Node(5)
        let node3 = Node(3)
        let node0 = Node(0)
        
        let node1 = Node(1, node0)
        let node2 = Node(2, node1, node3)
        let node4 = Node(4, node2, node5)
        
        let root = node4

        var result = [Int]()
        root.traverseBreadthFirst { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [4,2,5,1,3,0])
        XCTAssertEqual(Array(root.breadthFirstIterator), [4,2,5,1,3,0])
        
        result.removeAll(keepingCapacity: true)
        root.traversePreOrder { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [4,2,1,0,3,5])
        XCTAssertEqual(Array(root.preOrderIterator), [4,2,1,0,3,5])

        result.removeAll(keepingCapacity: true)
        root.traverseInOrder { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [0,1,2,3,4,5])
        XCTAssertEqual(Array(root.inOrderIterator), [0,1,2,3,4,5])

        result.removeAll(keepingCapacity: true)
        root.traverseOutOrder { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [5,4,3,2,1,0])
        XCTAssertEqual(Array(root.outOrderIterator), [5,4,3,2,1,0])

        result.removeAll(keepingCapacity: true)
        root.traversePostOrder { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [0,1,3,2,5,4])
        XCTAssertEqual(Array(root.postOrderIterator), [0,1,3,2,5,4])
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
