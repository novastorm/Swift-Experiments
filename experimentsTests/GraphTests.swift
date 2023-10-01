//
//  GraphTests.swift
//  experimentsTests
//
//  Created by Adland Lee on 10/1/23.
//  Copyright © 2023 4MFD. All rights reserved.
//

import XCTest
@testable import experiments


class GraphTests: XCTestCase {
    typealias TestType = Int
    typealias TestGraphType = ADL_Graph<TestType>

    func test_bfs_traversal() {
        var start: TestGraphType!
        var vertices = [TestGraphType]()
        
        for i in 0..<10 {
            vertices.append(TestGraphType(i))
        }
        
        start = vertices[0]
        
        vertices[0].neighbors.insert(vertices[1])
        vertices[0].neighbors.insert(vertices[2])
        vertices[0].neighbors.insert(vertices[3])
        
        vertices[1].neighbors.insert(vertices[4])
        vertices[1].neighbors.insert(vertices[5])

        vertices[2].neighbors.insert(vertices[6])
        vertices[2].neighbors.insert(vertices[7])
        
        vertices[3].neighbors.insert(vertices[8])
        vertices[3].neighbors.insert(vertices[9])

        start.traverseBreadthFirst { value in
            print(value)
        }
    }

}
