//
//  ADL_BinaryHeap.swift
//  experiments
//
//  Created by Bahlreighn on 7/8/19.
//  Copyright © 2019 4MFD. All rights reserved.
//

import Foundation

protocol BinaryHeapComparable {
    func compare(_ other: Self) -> ComparisonResult
}

//class ADL_BinaryHeap {
//    var buffer: CFBinaryHeap
//
//    init() {
//        let callbacks = CFBinaryHeapCallBacks()
//        callbacks.version = 0
//        callbacks.retain = {
//            return UnsafePointer<Any>
//        }
//    }
//}

class Task : Comparable, CustomStringConvertible {
    var priority : Int
    var name: String
    init(priority: Int, name: String) {
        self.priority = priority
        self.name = name
    }
    var description: String {
        return "\(priority), \(name)"
    }
    
    static func == (t1: Task, t2: Task) -> Bool {
        return t1.priority == t2.priority
    }
    static func < (t1: Task, t2: Task) -> Bool {
        return t1.priority < t2.priority
    }
}

struct TaskPriorityQueue {
    let heap : CFBinaryHeap = {
        var callBacks = CFBinaryHeapCallBacks(
            version: 0,
            retain: { // (allocator, unsafeRawPointer) in
//                UnsafePointer(Unmanaged<Task>.fromOpaque(OpaquePointer($1)).retain().toOpaque())
//                if let pointer = $1 {
//                    return UnsafeRawPointer($1)
//                }
                return UnsafeRawPointer($1)
            },
//            retain: nil,
            release: { // (allocator, unsafeRawPointer) in
////                Unmanaged<Task>.fromOpaque(OpaquePointer($1)).release()
//                if let pointer = $1 {
//                    pointer.deallocate()
//                }
                $1?.deallocate()
            },
//            release: nil,
            copyDescription: nil,
            compare: { (ptr1, ptr2, _) in
//                let t1 : Task = Unmanaged<Task>.fromOpaque(COpaquePointer(ptr1)).takeUnretainedValue()
                let t1: Task = (ptr1?.load(as: Task.self))!
//                let t2 : Task = Unmanaged<Task>.fromOpaque(COpaquePointer(ptr2)).takeUnretainedValue()
                let t2: Task = (ptr2?.load(as: Task.self))!
                return
                    t1 == t2 ? CFComparisonResult.compareEqualTo
                    :
                    t1 < t2 ? CFComparisonResult.compareLessThan
                    :
                    CFComparisonResult.compareGreaterThan
            })
        return CFBinaryHeapCreate(nil, 0, &callBacks, nil)
    }()
    var count : Int { return CFBinaryHeapGetCount(heap) }
    mutating func push(_ t: Task) {
//        CFBinaryHeapAddValue(heap, UnsafePointer(Unmanaged.passUnretained(t).toOpaque()))
        var t = t
        CFBinaryHeapAddValue(heap, &t)
    }
    func peek() -> Task {
//        return Unmanaged<Task>.fromOpaque(COpaquePointer(CFBinaryHeapGetMinimum(heap))).takeUnretainedValue()
        return (CFBinaryHeapGetMinimum(heap)?.load(as: Task.self))!
    }
    mutating func pop() -> Task {
//        let result = Unmanaged<Task>.fromOpaque(COpaquePointer(CFBinaryHeapGetMinimum(heap))).takeUnretainedValue()
        let result = (CFBinaryHeapGetMinimum(heap)?.load(as: Task.self))!
        CFBinaryHeapRemoveMinimumValue(heap)
        return result
    }
}
