//
// Created by Scott Moon on 2019-08-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct ArrayIterator<T>: IteratorProtocol {
  var currentElement: [T]

  public init(elements: [T]) {
    self.currentElement = elements
  }

  public mutating func next() -> T? {
    return self.currentElement.isEmpty
      ? nil
      : self.currentElement.popLast()
  }

}

extension ArrayIterator {

  public init<S: Sequence>(_ s: S) where S.Iterator.Element == T {
    self.currentElement = Array(s.reversed())
  }

}
