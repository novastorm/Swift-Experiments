//
//  ADL_Array+BubbleSort.swift
//  experiments
//
//  Created by Bahlreighn on 7/14/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import Foundation

extension Array where Element: Comparable {
    @discardableResult
    mutating func bubbleSortFrontToBack() -> Int {
        var compares = 0
        for _ in 1 ..< count {
            for j in 1 ..< count {
                compares += 1
                if self[j-1] > self[j] {
                    swapAt(j-1, j)
                }
            }
        }
        return compares
    }
    
    @discardableResult
    mutating func bubbleSortFrontToBackSwapCheck() -> Int {
        var compares = 0
        var swapped: Bool
        for _ in 0 ..< count {
            swapped = false
            for j in 1 ..< count {
                compares += 1
                if self[j-1] > self[j] {
                    swapAt(j-1, j)
                    swapped = true
                }
            }
            if !swapped {
                break
            }
        }
        return compares
    }
    
    @discardableResult
    mutating func bubbleSortFrontToBackSwapCheckEfficient() -> Int {
        var compares = 0
        var swapped: Bool
        for i in 0 ..< count {
            swapped = false
            for j in 1 ..< count-i {
                compares += 1
                if self[j-1] > self[j] {
                    swapAt(j-1, j)
                    swapped = true
                }
            }
            if !swapped {
                break
            }
        }
        return compares
    }

    @discardableResult
    mutating func bubbleSortBackToFront() -> Int {
        var compares = 0
        for _ in 1 ..< count {
            for j in stride(from: count-1, through: 1, by: -1) {
                compares += 1
                if self[j-1] > self[j] {
                    swapAt(j-1, j)
                }
            }
        }
        return compares
    }
    
    func bubbleSortedBackToFront() -> Array {
        var newArray = self
        newArray.bubbleSortBackToFront()
        return newArray
    }
    
    @discardableResult
    mutating func bubbleSortBackToFrontSwapCheck() -> Int {
        var compares = 0
        var swapped: Bool
        for _ in 1 ..< count {
            swapped = false
            for j in stride(from: count-1, through: 1, by: -1) {
                compares += 1
                if self[j-1] > self[j] {
                    swapAt(j-1, j)
                    swapped = true
                }
            }
            if !swapped {
                break
            }
        }
        return compares
    }

    @discardableResult
    mutating func bubbleSortBackToFrontSwapCheckEfficient() -> Int {
        var compares = 0
        var swapped: Bool
        for i in 1 ..< count {
            swapped = false
            for j in stride(from: count-1, through: i, by: -1) {
                compares += 1
                if self[j-1] > self[j] {
                    swapAt(j-1, j)
                    swapped = true
                }
            }
            if !swapped {
                break
            }
        }
        return compares
    }
}
