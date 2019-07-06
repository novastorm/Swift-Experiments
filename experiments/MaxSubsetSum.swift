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
    // iterative top down naive (fails test cases)
    public static func test(_ arr: [Int]) -> Int {
        var result: Int!
        var memo = [Int: Int]()
        
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
    
    // recursive bottom up
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

    // Recursively bottom up with index pointers
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

    // Recursively bottom up with memo and index pointers
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

    // recursive top down
    public static func recursiveTopDown(_ array: [Int]) -> Int {
        var result: Int!
        //        if array.count <= 2 {
        //            fatalError("array.count must be greater than 2")
        //        }
        //        else if array.count == 3 {
        precondition(array.count > 2)
        let lastIndex = array.count-1
        if array.count == 3 {
            result = array[lastIndex] + array[lastIndex-2]
        }
        else if array.count == 4 {
            result = max(
                array[lastIndex] + array[...(lastIndex-2)].max()!,
                recursiveTopDown(Array(array[...(lastIndex-1)]))
            )
        }
        else {
            result = max(
                array[lastIndex] + array[...(lastIndex-2)].max()!,
                array[lastIndex] + recursiveTopDown(Array(array[...(lastIndex-2)])),
                recursiveTopDown(Array(array[...(lastIndex-1)]))
            )
        }
        return result
    }

    // Recursive top down with index pointers
    public static func recursiveTopDownIndexed(_ array: [Int]) -> Int {
        return recursiveTopDownIndexed(array, lastIndex: array.count-1)
    }
    
    public static func recursiveTopDownIndexed(_ array: [Int], lastIndex: Int) -> Int {
        var result: Int!
        precondition(array.count > 2)
        if lastIndex == 2 {
            result = array[lastIndex] + array[lastIndex-2]
        }
        else if lastIndex == 3 {
            result = max(
                array[lastIndex] + array[...(lastIndex-2)].max()!,
                recursiveTopDownIndexed(array, lastIndex: lastIndex-1)
            )
        }
        else {
            result = max(
                array[lastIndex] + array[...(lastIndex-2)].max()!,
                array[lastIndex] + recursiveTopDownIndexed(array, lastIndex: lastIndex-2),
                recursiveTopDownIndexed(array, lastIndex: lastIndex-1)
            )
        }
        return result
    }

    // Recursive top down memoized with index pointers
    public static func recursiveTopDownIndexedMemoized(_ array: [Int]) -> Int {
        var memo = [Int: Int]()
        
        func recurse(_ array: [Int], memo: inout [Int:Int], lastIndex: Int) -> Int {
            var result: Int!
            precondition(array.count > 2)
            if let value = memo[lastIndex] {
                return value
            }
            if lastIndex == 2 {
                result = array[lastIndex] + array[lastIndex-2]
            }
            else if lastIndex == 3 {
                result = max(
                    array[lastIndex] + array[...(lastIndex-2)].max()!,
                    recurse(array, memo: &memo, lastIndex: lastIndex-1)
                )
            }
            else {
                result = max(
                    array[lastIndex] + array[...(lastIndex-2)].max()!,
                    array[lastIndex] + recurse(array, memo: &memo, lastIndex: lastIndex-2),
                    recurse(array, memo: &memo, lastIndex: lastIndex-1)
                )
            }
            memo[lastIndex] = result
            return result
        }
        
        return recurse(array, memo: &memo, lastIndex: array.count-1)
    }

    // Iteratively top down memoized
    public static func iterativeTopDownIndexedMemoized(_ array: [Int]) -> Int {
        var result: Int!
        var memo = [Int: Int]()
//        var memo = [Int?](repeating: nil, count: array.count)
        var arrayMaxMemo = [Int:Int]()

        for lastIndex in 2 ..< array.count {
            if lastIndex == 2 {
                result = array[lastIndex] + array[lastIndex-2]
                arrayMaxMemo[lastIndex-2] = array[lastIndex-2]
                arrayMaxMemo[lastIndex-1] = max(array[lastIndex-1], arrayMaxMemo[lastIndex-2]!)
                arrayMaxMemo[lastIndex] = max(array[lastIndex], arrayMaxMemo[lastIndex-1]!)
            }
            else if lastIndex == 3 {
                arrayMaxMemo[lastIndex] = max(array[lastIndex], arrayMaxMemo[lastIndex-1]!)
                result = max(
                    array[lastIndex] + arrayMaxMemo[lastIndex-2]!,
                    memo[lastIndex-1]!
                )
            }
            else {
                arrayMaxMemo[lastIndex] = max(array[lastIndex], arrayMaxMemo[lastIndex-1]!)
                result = max(
                    array[lastIndex] + arrayMaxMemo[lastIndex-2]!,
                    array[lastIndex] + memo[lastIndex-2]!,
                    memo[lastIndex-1]!
                )
            }
            memo[lastIndex] = result
        }
        return memo[array.count-1]!
    }

    // Iteratively top down memoized and space efficient
    public static func iterativeTopDownSpaceEfficient(_ array: [Int]) -> Int {
        struct CircularList<T> {
            let size: Int
            var headIndex: Int
            var buffer: [T?]
            
            init(size: Int) {
                self.size = size
                buffer = [T?](repeating: nil, count: size)
                headIndex = size - 1
            }
            
            mutating func push(_ datum: T) {
                headIndex = (headIndex + 1) % size
                buffer[headIndex] = datum
            }
            
            func peek(_ offset: Int = 0) -> T? {
                let targetIndex = (((headIndex + offset) % size) + size) % size
                return buffer[targetIndex]
            }
        }
        var result: Int!
        var memo = CircularList<Int>(size: 2)
        var arrayMaxMemo = CircularList<Int>(size: 3)
        
        for lastIndex in 2 ..< array.count {
            if lastIndex == 2 {
                result = array[lastIndex] + array[lastIndex-2]
                arrayMaxMemo.push(array[lastIndex-2])
                arrayMaxMemo.push(max(array[lastIndex-1], arrayMaxMemo.peek()!))
                arrayMaxMemo.push(max(array[lastIndex]  , arrayMaxMemo.peek()!))
            }
            else if lastIndex == 3 {
                arrayMaxMemo.push(max(array[lastIndex], arrayMaxMemo.peek()!))
                result = max(
                    array[lastIndex] + arrayMaxMemo.peek(-2)!,
                    memo.peek()!
                )
            }
            else {
                arrayMaxMemo.push(max(array[lastIndex], arrayMaxMemo.peek()!))
                result = max(
                    array[lastIndex] + arrayMaxMemo.peek(-2)!,
                    array[lastIndex] + memo.peek(-1)!,
                    memo.peek()!
                )
            }
            memo.push(result)
        }
        return memo.peek()!
    }
}
