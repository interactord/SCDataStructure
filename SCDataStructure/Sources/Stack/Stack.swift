//
// Created by Scott Moon on 2019-08-12.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct Stack<T> {
	private var elements: [T]

	public init() {
		elements = [T]()
	}

	public init(_ elements: [T]) {
		self.elements = elements
	}

	public mutating func pop() -> T? {
		return self.elements.popLast()
	}

	public mutating func push(_ element: T) {
		self.elements.append(element)
	}

	public var peek: T? {
		return self.elements.last
	}

	public var isEmpty: Bool {
		return self.elements.isEmpty
	}

	public var count: Int {
		return self.elements.count
	}
}

extension Stack: CustomStringConvertible, CustomDebugStringConvertible {
	public var description: String {
		return self.elements.description
	}

	public var debugDescription: String {
		return self.elements.debugDescription
	}
}

extension Stack: ExpressibleByArrayLiteral {
	public init(arrayLiteral elements: T...) {
		self.init(elements)
	}
}

extension Stack: Sequence {
  public func makeIterator() -> AnyIterator<T> {
    return AnyIterator(
			IndexingIterator(_elements: elements.lazy.reversed())
		)
	}
}
