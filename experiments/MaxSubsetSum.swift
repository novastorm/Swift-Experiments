//
//  MaxSubsetSum.swift
//  experiments
//
//  Created by Bahlreighn on 7/4/19.
//  Copyright © 2019 4MFD. All rights reserved.
//
//  https://www.hackerrank.com/challenges/max-array-sum/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dynamic-programming
//

import Foundation

class MaxSubsetSum {
    // Recursively
    public static func test(_ arr: [Int]) -> Int {
        var result: Int!
        var memo = [Int: Int]()
        // var memo = [Int?](repeating: nil, count: arr.count)
        
        for index in 0 ..< arr.count {
            if index < 2 {
                result = Array(arr[0...index]).max()
                // result = arr[index]
            }
            else {
                result = max(
                    arr[index],
                    arr[index] + memo[index-2]!,
                    memo[index-1]!
                )
            }
            memo[index] = result
        }
        return memo[arr.count-1]!
    }
    
    public static func recursiveBottomUp(_ array: [Int]) -> Int {
        var result: Int!
//        if array.count <= 2 {
//            fatalError("array.count must be greater than 2")
//        }
//        else if array.count == 3 {
        precondition(array.count > 2)
        if array.count == 3 {
            result = array[0] + array[2]
        }
        else if array.count == 4 {
            result = max(
                array[0] + array[2...].max()!,
                recursiveBottomUp(Array(array[1...]))
            )
        }
        else {
            result = max(
                array[0] + array[2...].max()!,
                array[0] + recursiveBottomUp(Array(array[2...])),
                recursiveBottomUp(Array(array[1...]))
            )
        }
        return result
    }

    // Recursively with index pointers
    public static func recursiveBottomUpIndexed(_ array: [Int], startIndex: Int = 0) -> Int {
        var result: Int!
        precondition(array.count > 2)
//        if startIndex > array.count - 3 {
//            fatalError("startIndex must notarray.count must be greater than 2")
//        }
//        else if startIndex == array.count - 3 {
        if startIndex == array.count - 3 {
            result = array[startIndex] + array[startIndex+2]
        }
        else if startIndex == array.count - 4 {
            result = max(
                array[startIndex] + array[(startIndex+2)...].max()!,
                recursiveBottomUpIndexed(array, startIndex: startIndex+1)
            )
        }
        else {
            result = max(
                array[startIndex] + array[(startIndex+2)...].max()!,
                array[startIndex] + recursiveBottomUpIndexed(array, startIndex: startIndex+2),
                recursiveBottomUpIndexed(array, startIndex: startIndex+1)
            )
        }
        return result
    }

    // Recursively with memo and index pointers
    public static func recursiveBottomUpIndexedMemoized(_ array: [Int]) -> Int {
        var memo = [Int: Int]()

        func recurse(_ array: [Int], memo: inout [Int: Int], startIndex: Int = 0) -> Int {
            var result: Int!
            if let value = memo[startIndex] {
                return value
            }
            
            if startIndex == array.count - 3 {
                result = array[startIndex] + array[startIndex+2]
            }
            else if startIndex == array.count - 4 {
                result = max(
                    array[startIndex] + array[(startIndex+2)...].max()!,
                    recurse(array, memo: &memo, startIndex: startIndex+1)
                )
            }
            else {
                result = max(
                    array[startIndex] + array[(startIndex+2)...].max()!,
                    array[startIndex] + recurse(array, memo: &memo, startIndex: startIndex+2),
                    recurse(array, memo: &memo, startIndex: startIndex+1)
                )
            }

            memo[startIndex] = result
            return result
        }
        
        return recurse(array, memo: &memo)
    }

    public static func recursiveTopDown(_ array: [Int]) -> Int {
        var result: Int!
        //        if array.count <= 2 {
        //            fatalError("array.count must be greater than 2")
        //        }
        //        else if array.count == 3 {
        precondition(array.count > 2)
        if array.count == 3 {
            result = array[array.count-1] + array[array.count-1-2]
        }
        else if array.count == 4 {
            result = max(
                array[array.count-1] + array[...(array.count-1-2)].max()!,
                recursiveTopDown(Array(array[...(array.count-1-1)]))
            )
        }
        else {
            result = max(
                array[array.count-1] + array[...(array.count-1-2)].max()!,
                array[array.count-1] + recursiveTopDown(Array(array[...(array.count-1-2)])),
                recursiveTopDown(Array(array[...(array.count-1-1)]))
            )
        }
        return result
    }

    // Recursively with index pointers
    public static func recursiveTopDownIndexed(_ array: [Int], startIndex: Int = 0) -> Int {
        var result: Int!
        precondition(array.count > 2)
        //        if startIndex > array.count - 3 {
        //            fatalError("startIndex must notarray.count must be greater than 2")
        //        }
        //        else if startIndex == array.count - 3 {
        if startIndex == array.count - 3 {
            result = array[startIndex] + array[startIndex+2]
        }
        else if startIndex == array.count - 4 {
            result = max(
                array[startIndex] + array[(startIndex+2)...].max()!,
                recursiveTopDownIndexed(array, startIndex: startIndex+1)
            )
        }
        else {
            result = max(
                array[startIndex] + array[(startIndex+2)...].max()!,
                array[startIndex] + recursiveTopDownIndexed(array, startIndex: startIndex+2),
                recursiveTopDownIndexed(array, startIndex: startIndex+1)
            )
        }
        return result
    }

    // Iteratively build with memo
    public static func iterativeTopDownIndexedMemoized(_ array: [Int]) -> Int {
        var result: Int!
        //    var memo = [Int: Int]()
        var memo = [Int?](repeating: nil, count: array.count)
        
        for index in 0 ..< array.count {
            if index < 2 {
                result = array[index]
            }
            else {
                result = max(
                    array[index],
                    array[index] + array[index-2],
                    array[index-1]
                )
            }
            memo[index] = result
            //        print(array, index, result!)
        }
        return memo[array.count-1]!
    }

    // Iteratively build inplace
    public static func iterativeTopDownIndexedInPlace(_ array: inout [Int]) -> Int {
        var result: Int!
        
        for index in 0 ..< array.count {
            if index < 2 {
                result = array[index]
            }
            else {
                result = max(
                    array[index],
                    array[index] + array[index-2],
                    array[index-1]
                )
            }
            array[index] = result
            //        print(array, index, result!)
        }
        return array.last!
    }

}

//let array = [-2, 1, 3, -4, 5]
//var isFirst = true
//for version in MaxSubsetSumVersion.allCases {
//    if !isFirst {
//        print()
//    }
//    isFirst = false
//    maxSubsetSum(array, version: version)
//}

//var a2 = [Int]()
//let size = 1_000
//a2.reserveCapacity(size)
//for _ in 0 ..< size {
//    a2.append(Int.random(in: -size ... size))
//}
//a2
//
//maxSubsetSum(a2, version: .v4)
//maxSubsetSum(a2, version: .v3)

//: [Next](@next)
