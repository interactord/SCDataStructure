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
