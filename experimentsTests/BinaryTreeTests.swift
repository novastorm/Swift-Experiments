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
    var root: ADL_BinaryTreeNode<TestType>!
    
    override func setUp() {
        root = nil
    }

    override func tearDown() {
        root = nil
    }

    func test_NodeInitialization() {
        typealias Node = ADL_BinaryTreeNode
        let node = Node(0)
        XCTAssertNotNil(node)
        XCTAssertEqual(node.value, 0)
        XCTAssertNil(node.left)
        XCTAssertNil(node.right)
    }
    
    func test_TreeTraversal() {
        /*
                4
              /   \
             2     5
            / \
           1   3
          /
         0
         
         */
        typealias Node = ADL_BinaryTreeNode
        
        let node5 = Node(5)
        let node3 = Node(3)
        let node0 = Node(0)
        
        let node1 = Node(1, node0)
        let node2 = Node(2, node1, node3)
        let node4 = Node(4, node2, node5)
        
        let root = node4
        
        let bt = ADL_BinaryTree(root)

        var result = [Int]()
        bt.traverseBreadthFirstIteratively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [4,2,5,1,3,0])
        XCTAssertEqual(Array(bt.breadthFirstIterator), [4,2,5,1,3,0])
        
        
        result.removeAll(keepingCapacity: true)
        bt.traversePreOrderRecursively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [4,2,1,0,3,5])
        result.removeAll(keepingCapacity: true)
        bt.traversePreOrderIteratively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [4,2,1,0,3,5])
        XCTAssertEqual(Array(bt.preOrderIterator), [4,2,1,0,3,5])

        
        result.removeAll(keepingCapacity: true)
        bt.traverseInOrderRecursively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [0,1,2,3,4,5])
        result.removeAll(keepingCapacity: true)
        bt.traverseInOrderIteratively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [0,1,2,3,4,5])
        XCTAssertEqual(Array(bt.inOrderIterator), [0,1,2,3,4,5])

        
        result.removeAll(keepingCapacity: true)
        bt.traverseOutOrderRecursively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [5,4,3,2,1,0])
        result.removeAll(keepingCapacity: true)
        bt.traverseOutOrderIteratively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [5,4,3,2,1,0])
        XCTAssertEqual(Array(bt.outOrderIterator), [5,4,3,2,1,0])

        
        result.removeAll(keepingCapacity: true)
        bt.traversePostOrderRecursively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [0,1,3,2,5,4])
        result.removeAll(keepingCapacity: true)
        bt.traversePostOrderIteratively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [0,1,3,2,5,4])
        XCTAssertEqual(Array(bt.postOrderIterator), [0,1,3,2,5,4])
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    func test_TreeTraversal_2() {
        /*
                1
                  \
                   3
                    \
                     2
                    /
                   5
                  /
                 4
         
         */
        typealias Node = ADL_BinaryTreeNode
        
        let node4 = Node(4)
        
        let node5 = Node(5, node4)
        let node2 = Node(2, node5)
        let node3 = Node(3, nil, node2)
        let node1 = Node(1, nil, node3)

        let root = node1
        
        let bt = ADL_BinaryTree(root)

        var result = [Int]()
        bt.traverseBreadthFirstIteratively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [1,3,2,5,4])
        XCTAssertEqual(Array(bt.breadthFirstIterator), [1,3,2,5,4])
        
        
        result.removeAll(keepingCapacity: true)
        bt.traversePreOrderRecursively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [1,3,2,5,4])
        result.removeAll(keepingCapacity: true)
        bt.traversePreOrderIteratively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [1,3,2,5,4])
        XCTAssertEqual(Array(bt.preOrderIterator), [1,3,2,5,4])

        
        result.removeAll(keepingCapacity: true)
        bt.traverseInOrderRecursively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [1,3,4,5,2])
        result.removeAll(keepingCapacity: true)
        bt.traverseInOrderIteratively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [1,3,4,5,2])
        XCTAssertEqual(Array(bt.inOrderIterator), [1,3,4,5,2])

        
        result.removeAll(keepingCapacity: true)
        bt.traverseOutOrderRecursively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [2,5,4,3,1])
        result.removeAll(keepingCapacity: true)
        bt.traverseOutOrderIteratively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [2,5,4,3,1])
        XCTAssertEqual(Array(bt.outOrderIterator), [2,5,4,3,1])

        
        result.removeAll(keepingCapacity: true)
        bt.traversePostOrderRecursively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [4,5,2,3,1])
        result.removeAll(keepingCapacity: true)
        bt.traversePostOrderIteratively() { (value) in
            result.append(value)
        }
        XCTAssertEqual(result, [4,5,2,3,1])
        XCTAssertEqual(Array(bt.postOrderIterator), [4,5,2,3,1])
    }
    
}

