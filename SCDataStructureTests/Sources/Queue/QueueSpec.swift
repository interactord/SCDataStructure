//
// Created by Scott Moon on 2019-08-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import SCDataStructure

class QueueSpec: XCTestCase {

  var sut: Queue<Int>!

  override func setUp() {
    super.setUp()
    sut = Queue<Int>()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_empty_element_sut() {
    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.dequeue())
  }

  func test_limit_space_sut() {

    sut.enqueue(10)
    sut.enqueue(20)

    XCTAssertFalse(sut.isEmpty)
    XCTAssertEqual(sut.peek, 10)
    XCTAssertEqual(sut.dequeue(), 10)

    XCTAssertEqual(sut.peek, 20)
    XCTAssertEqual(sut.dequeue(), 20)

    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.dequeue())
  }

  func test_clear_sut() {
    sut.enqueue(10)
    sut.enqueue(20)

    XCTAssertFalse(sut.isEmpty)
    XCTAssertEqual(sut.peek, 10)

    sut.clear()

    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.dequeue())
  }
}

// MARK: - CustomDebugStringConvertible, CustomStringConvertible
extension QueueSpec {
  func test_empty_element_description() {
    XCTAssertEqual(sut.debugDescription, "Optional([])")
    XCTAssertEqual(sut.description, "[]")
  }

  func test_many_element_description() {
    sut.enqueue(10)
    sut.enqueue(20)
    sut.enqueue(30)

    XCTAssertEqual(sut.debugDescription, "Optional([10, 20, 30])")
    XCTAssertEqual(sut.description, "[10, 20, 30]")
  }
}

// MARK: - ExpressibleByArrayLiteral
extension QueueSpec {
  func test_case1_array_init() {
    let list = Queue(arrayLiteral: 10, 20, 30)
    XCTAssertFalse(list.isEmpty)
    XCTAssertEqual(list.count, 3)
  }

  func test_case2_array_init() {
    let list: Queue<Int> = [10, 20, 30]
    XCTAssertFalse(list.isEmpty)
    XCTAssertEqual(list.count, 3)
  }
}

// MARK: - Sequence
extension QueueSpec {
  func test_case1_iterator() {
    var list = Queue<Int>()
    list.enqueue(10)
    list.enqueue(20)
    list.enqueue(30)

    for element in list {
      sut.enqueue(element)
    }

    XCTAssertFalse(sut.isEmpty)
    XCTAssertEqual(sut.count, 3)
    XCTAssertEqual(sut.peek, 10)
  }

  func test_case2_iterator() {
    sut.enqueue(10)
    sut.enqueue(20)
    sut.enqueue(30)

    let expectedList = [10, 20, 30]
    let resultList = sut.compactMap { $0 }
    XCTAssertEqual(expectedList, resultList)

    XCTAssertFalse(sut.isEmpty)
    XCTAssertEqual(sut.count, 3)
    XCTAssertEqual(sut.peek, 10)
  }
}

// MARK: - MutableCollection
extension QueueSpec {
  func test_case1_mutableCollection() {
    sut.enqueue(10)
    sut.enqueue(20)
    sut.enqueue(30)

    XCTAssertEqual(sut[0], 10)
    XCTAssertEqual(sut[1], 20)
    XCTAssertEqual(sut[2], 30)

    XCTAssertEqual(sut.startIndex, 0)
    XCTAssertEqual(sut.endIndex, 2)
  }

  func test_case2_mutableCollection() {
    sut.enqueue(10)
    sut.enqueue(20)
    sut.enqueue(30)

    sut[2] = 40
    XCTAssertNotEqual(30, sut[2])

    var startIndex = sut.startIndex

    while startIndex != sut.endIndex {
      startIndex = sut.index(after: startIndex)
    }
    XCTAssertEqual(startIndex, sut.endIndex)
  }

}
