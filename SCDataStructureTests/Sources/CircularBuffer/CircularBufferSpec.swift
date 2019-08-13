//
// Created by Scott Moon on 2019-08-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import SCDataStructure

class CircularBufferSpec: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func test_case1_init() {
    var sut = CircularBuffer<Int>(withCapacity: -1)

    XCTAssertNotEqual(sut.capacity, -1)
    XCTAssertEqual(sut.capacity, 16)
    XCTAssertEqual(sut.count, 0)
  }

  func test_case2_init() {
    var sut = CircularBuffer<Int>(withCapacity: 3)

    XCTAssertNotEqual(sut.capacity, 3)
    XCTAssertEqual(sut.capacity, 4)
  }

  func test_case3_init() {
    var sut = CircularBuffer<Int>(withCapacity: 10)

    XCTAssertNotEqual(sut.capacity, 10)
    XCTAssertEqual(sut.capacity, 16)
  }

  func test_case1_overwrite_push() {
    var sut = CircularBuffer<Int>(withCapacity: 4)

    XCTAssertEqual(sut.capacity, 4)
    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.pop())
    XCTAssertFalse(sut.isFull)

    sut.push(100)
    sut.push(120)
    sut.push(125)
    sut.push(130)

    XCTAssertFalse(sut.isEmpty)
    XCTAssertEqual(sut.count, 4)
    XCTAssertTrue(sut.isFull)

    XCTAssertEqual(sut.peek, 100)
    let resultPop1 = sut.pop()

    XCTAssertEqual(resultPop1, 100)
    /// head : 1, tail: 0
    sut.push(150)

    sut.push(160)

    sut.push(170)

    XCTAssertEqual(sut.peek, 130)
    let resultPop2 = sut.pop()
    XCTAssertEqual(resultPop2, 130)

    XCTAssertEqual(sut.peek, 150)
    let resultPop3 = sut.pop()
    XCTAssertEqual(resultPop3, 150)

    XCTAssertEqual(sut.peek, 160)
    let resultPop4 = sut.pop()
    XCTAssertEqual(resultPop4, 160)

    XCTAssertEqual(sut.count, 1)

    sut.clear()
    XCTAssertEqual(sut.capacity, 4)
    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.pop())
    XCTAssertFalse(sut.isFull)
  }

  func test_case1_ignore_push() {
    var sut = CircularBuffer<Int>(withCapacity: 4, overwriteOperation: .ignore)

    XCTAssertEqual(sut.capacity, 4)
    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.pop())
    XCTAssertFalse(sut.isFull)

    sut.push(100)
    sut.push(120)
    sut.push(125)
    sut.push(130)

    XCTAssertFalse(sut.isEmpty)
    XCTAssertEqual(sut.count, 4)
    XCTAssertTrue(sut.isFull)

    XCTAssertEqual(sut.peek, 100)
    let resultPop1 = sut.pop()

    XCTAssertEqual(resultPop1, 100)
    /// head : 1, tail: 0
    sut.push(150)

    sut.push(160)

    sut.push(170)

    XCTAssertEqual(sut.peek, 120)

    XCTAssertEqual(sut.count, 4)

    sut.clear()
    XCTAssertEqual(sut.capacity, 4)
    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
    XCTAssertNil(sut.pop())
    XCTAssertFalse(sut.isFull)
  }
}

// MARK: - CustomStringConvertible

extension CircularBufferSpec {
  func test_case1_description() {
    let sut = CircularBuffer<Int>()

    XCTAssertEqual(sut.description, "")
  }

  func test_case2_description() {
    var sut = CircularBuffer<Int>(withCapacity: 2)
    sut.push(1)
    sut.push(2)

    XCTAssertEqual(sut.description, "1([head, tail]), 2")

    sut.pop()
    XCTAssertEqual(sut.description, "1([tail]), 2([head])")
  }
}

// MARK: - ExpressibleByArrayLiteral

extension CircularBufferSpec {
  func test_case1_expressibleByArrayLiteral_init() {
    var sut: CircularBuffer<Int> = [10, 20, 30, 40]

    XCTAssertEqual(sut.capacity, 4)
    XCTAssertEqual(sut.count, 4)
    XCTAssertTrue(sut.isFull)
    XCTAssertFalse(sut.isEmpty)
  }
}

// MARK: - Sequence

extension CircularBufferSpec {
  func test_case1_makeIterator() {
    var sut = CircularBuffer<Int>(withCapacity: 4)
    sut.push(10)
    sut.push(20)
    sut.push(30)

    let result = sut.compactMap { $0 }
    XCTAssertEqual(result, [10, 20, 30])
  }

  func test_case2_makeIterator() {
    var sut = CircularBuffer<Int>(withCapacity: 4)
    sut.push(10)
    sut.pop()

    let result = sut.compactMap { $0 }
    XCTAssertEqual(result, [])
  }

  func test_case3_makeIterator() {
    var sut = CircularBuffer<Int>(withCapacity: 4)
    sut.push(10)
    sut.push(20)
    sut.push(30)
    sut.push(40)

    let result = sut.compactMap { $0 }
    XCTAssertEqual(result, [10, 20, 30, 40])
  }

  func test_case4_makeIterator() {
    var sut = CircularBuffer<Int>(withCapacity: 4)
    sut.push(10)
    sut.push(20)
    sut.push(30)
    sut.push(40)

    sut.pop()
    sut.pop()
    sut.pop()

    let result = sut.compactMap { $0 }
    XCTAssertEqual(result, [40])
  }

   func test_case5_makeIterator() {
    var sut = CircularBuffer<Int>(withCapacity: 4)
    sut.push(10)
    sut.push(20)
    sut.push(30)
    sut.push(40)

    sut.pop()
    sut.pop()
    sut.pop()

    sut.push(50)
    sut.push(60)

    let result = sut.compactMap { $0 }
    XCTAssertEqual(result, [40, 50, 60])
  }

}
