//
// Created by Scott Moon on 2019-08-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import SCDataStructure

class PriorityQueueSpec: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func test_case1_init() {
    var sut = PriorityQueue<Int>()
    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.pop())
  }

  func test_case2_init() {
    var sut = PriorityQueue<Int>(startingValues: [1, 5, 4, 3, 2])

    XCTAssertFalse(sut.isEmpty)
    XCTAssertEqual(sut.count, 5)

    XCTAssertEqual(sut.pop(), 5)
    XCTAssertEqual(sut.pop(), 4)
    XCTAssertEqual(sut.pop(), 3)
    XCTAssertEqual(sut.pop(), 2)
    XCTAssertEqual(sut.pop(), 1)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.pop())
  }

  func test_case1_push() {
    var sut = PriorityQueue<Int>()
    sut.push(1)
    sut.push(5)
    sut.push(3)
    sut.push(4)
    sut.push(2)

    XCTAssertEqual(sut.pop(), 5)
    XCTAssertEqual(sut.pop(), 4)
    XCTAssertEqual(sut.pop(), 3)
    XCTAssertEqual(sut.pop(), 2)
    XCTAssertEqual(sut.pop(), 1)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.pop())
  }

  func test_case1_remove() {
    var sut = PriorityQueue<Int>(startingValues: [1, 5, 4, 1, 1])
    sut.remove(first: 1)

    XCTAssertEqual(sut.pop(), 5)
    XCTAssertEqual(sut.pop(), 4)
    XCTAssertEqual(sut.pop(), 1)
    XCTAssertEqual(sut.pop(), 1)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.pop())
  }

  func test_case2_remove() {
    var sut = PriorityQueue<Int>(startingValues: [1, 5, 4, 1, 1])
    sut.remove(all: 1)

    XCTAssertEqual(sut.pop(), 5)
    XCTAssertEqual(sut.pop(), 4)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.pop())
  }

  func test_case1_clear() {
    var sut = PriorityQueue<Int>(startingValues: [1, 5, 4, 1, 1])
    sut.clear()

    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.pop())
  }
}

// MARK: - CustomStringConvertible, CustomDebugStringConvertible

extension PriorityQueueSpec {
  func test_case1_description() {
    let sut = PriorityQueue<Int>(startingValues: [1, 5, 4, 3, 2])
    XCTAssertEqual(sut.description, "[5, 3, 4, 1, 2]")
    XCTAssertEqual(sut.debugDescription, "[5, 3, 4, 1, 2]")
  }

  func test_case2_description() {
    let sut = PriorityQueue<Int>(ascending: true, startingValues: [1, 5, 4, 3, 2])
    XCTAssertEqual(sut.description, "[1, 2, 4, 3, 5]")
    XCTAssertEqual(sut.debugDescription, "[1, 2, 4, 3, 5]")
  }
}

// MARK: - IteratorProtocol

extension PriorityQueueSpec {
  func test_case1_next() {
    let sut = PriorityQueue<Int>(startingValues: [1, 5, 4, 3, 2])

    let result1 = sut.compactMap { $0 }
    XCTAssertEqual(result1, [5, 4, 3, 2, 1])

    let result2 = sut.map { $0 }
    XCTAssertEqual(result2, [5, 3, 4, 1, 2])
  }

  func test_case2_makeIterator() {
    let sut = PriorityQueue<Int>(ascending: true, startingValues: [1, 5, 4, 3, 2])

    let result1 = sut.compactMap { $0 }
    XCTAssertEqual(result1, [1, 2, 3, 4, 5])

    let result2 = sut.map { $0 }
    XCTAssertEqual(result2, [1, 2, 4, 3, 5])
  }

}

// MARK: - Collection

extension PriorityQueueSpec {
  func test_case1_subscript() {
    let sut = PriorityQueue<Int>(ascending: true, startingValues: [1, 5, 4, 3, 2])
    let result = sut[1]
    XCTAssertEqual(result, 2)
  }

  func test_case1_index() {
    let sut = PriorityQueue<Int>(ascending: true, startingValues: [1, 5, 4, 3, 2])
    let result = sut.index(after: 1)
    XCTAssertEqual(result, 2)
  }
}
