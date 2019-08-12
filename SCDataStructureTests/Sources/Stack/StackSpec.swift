//
// Created by Scott Moon on 2019-08-12.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import SCDataStructure

class StackSpec: XCTestCase {

  var sut: Stack<Int>!

  override func setUp() {
    super.setUp()
    sut = Stack<Int>()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_empty_stack() {

    XCTAssertEqual(sut.debugDescription, "Optional([])")
    XCTAssertEqual(sut.description, "[]")

    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
  }

  func test_one_element_stack() {
    sut.push(10)

    XCTAssertEqual(sut.debugDescription, "Optional([10])")
    XCTAssertEqual(sut.description, "[10]")

    XCTAssertFalse(sut.isEmpty)
    XCTAssertEqual(sut.count, 1)
    XCTAssertEqual(sut.peek, 10)

    let result = sut.pop()
    XCTAssertEqual(result, 10)

    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
  }

  func test_three_element_stack() {
    sut.push(10)
    sut.push(20)
    sut.push(30)

    XCTAssertEqual(sut.debugDescription, "Optional([10, 20, 30])")
    XCTAssertEqual(sut.description, "[10, 20, 30]")

    XCTAssertFalse(sut.isEmpty)
    XCTAssertEqual(sut.count, 3)
    XCTAssertEqual(sut.peek, 30)

    let result1 = sut.pop()
    XCTAssertEqual(result1, 30)
    XCTAssertEqual(sut.peek, 20)

    let result2 = sut.pop()
    XCTAssertEqual(result2, 20)
    XCTAssertEqual(sut.peek, 10)

    let result3 = sut.pop()
    XCTAssertEqual(result3, 10)

    XCTAssertTrue(sut.isEmpty)
    XCTAssertEqual(sut.count, 0)
    XCTAssertNil(sut.peek)
  }

}

// MARK: - ExpressibleByArrayLiteral

extension StackSpec {
  func test_expressibleByArrayLiteral_init() {
    var list: Stack<Int> = [10, 20, 30]

    XCTAssertEqual(list.description, "[10, 20, 30]")
    XCTAssertEqual(list.debugDescription, "[10, 20, 30]")

    XCTAssertFalse(list.isEmpty)
    XCTAssertEqual(list.count, 3)
    XCTAssertEqual(list.peek, 30)

    XCTAssertEqual(list.peek, 30)

    let result1 = list.pop()
    XCTAssertEqual(result1, 30)
    XCTAssertEqual(list.peek, 20)

    let result2 = list.pop()
    XCTAssertEqual(result2, 20)
    XCTAssertEqual(list.peek, 10)

    let result3 = list.pop()
    XCTAssertEqual(result3, 10)

    XCTAssertTrue(list.isEmpty)
    XCTAssertEqual(list.count, 0)
    XCTAssertNil(list.peek)

  }
}

// MARK: - ExpressibleByArrayLiteral

extension StackSpec {

  func test_makeIterator() {
    let list: Stack<Int> = [10, 20, 30]

    var resultList = [Int]()
    for element in list {
      resultList.append(element)
    }

    XCTAssertEqual(resultList, [10, 20, 30])
  }

}
