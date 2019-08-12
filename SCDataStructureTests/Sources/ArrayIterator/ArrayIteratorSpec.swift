//
// Created by Scott Moon on 2019-08-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import SCDataStructure

class ArrayIteratorSpec: XCTestCase {

  func test_empty_sut() {
    var sut: ArrayIterator<Int> = ArrayIterator(elements: [])
    XCTAssertNil(sut.next())
  }

  func test_many_element_sut() {
    var sut: ArrayIterator<Int> = ArrayIterator(elements: [10, 20, 30])

    XCTAssertEqual(sut.next(), 30)
    XCTAssertEqual(sut.next(), 20)
    XCTAssertEqual(sut.next(), 10)
    XCTAssertNil(sut.next())
  }

}
