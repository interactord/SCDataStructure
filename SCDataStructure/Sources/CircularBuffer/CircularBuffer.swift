//
// Created by Scott Moon on 2019-08-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

/// 세 요소를 추가할 때, 버퍼 전체 동작을 제어하는데 사용되는 열거형 구문
public enum CircularBufferOperation {
  case ignore, overwrite
}

/// 용량의 정해지지 않는 경우, 기본값으로 사용되는 구조체
private struct Constants {
  fileprivate static let defaultBufferCapacity: Int = 16
}

public struct CircularBuffer<T> {
  fileprivate var data: [T]
  fileprivate var head: Int = 0, tail: Int = 0

  private var internalCount: Int = 0
  private var overwriteOperation = CircularBufferOperation.overwrite

  /// 빈 CircularBuffer 구조체 생성. (기본값 사용)
  public init() {
    data = [T]()
    data.reserveCapacity(Constants.defaultBufferCapacity)
  }

  /// count 가 2의 거듭제곱인지 확인
  /// Remark: 만일 거듭 제곱이 아니면, 2의 거듭제곱 근사치로 count 값 조정
  public init(withCapacity capacity: Int, overwriteOperation: CircularBufferOperation = .overwrite) {
    var size = capacity
    if size < 1 {
      size = Constants.defaultBufferCapacity
    }

    if (size & (~size + 1)) != size {

      var bufferSize = 1
      while bufferSize < size {
        bufferSize = bufferSize << 1
      }
      size = bufferSize
    }

    data = [T]()
    data.reserveCapacity(size)
    self.overwriteOperation = overwriteOperation

  }

  fileprivate init<S: Sequence>(_ elements: S, count: Int) where S.Iterator.Element == T {
    self.init(withCapacity: count)
    elements.forEach { push($0) }
  }

  /// 큐에서 첫번째 요소를 제거하고 반환
  /// - 반환값:
  /// - 큐의 요소가 빈 경우, nil
  /// - 큐의 요소가 비어있지 않는 경우, 첫번째 요소 (제네릭 타입)
  @discardableResult
  public mutating func pop() -> T? {
    if isEmpty {
      return nil
    }

    let element = data[head]
    head = increment(at: head)
    internalCount -= 1
    return element
  }

  /// 버퍼를 빈상태로 변경
  public mutating func clear() {
    head = 0
    tail = 0
    internalCount = 0
    data.removeAll(keepingCapacity: true)
  }

  /// 매개값 `element`를 버퍼 맨 뒤에 추가
  /// 기본 메소드인 `overwritingOperation` 설정에 따라 로직이 다름
  /// overwrite 인 경우, 버퍼가 가득찼을 때 가장 오래된 요소에 덮어씀
  /// ignore 인 경우, 기존의 요소가 삭제 될때까지, 새로운 요소를 추가하지 않음
  /// 복잡성: O(1)
  public mutating func push(_ element: T) {
    if isFull {
      switch overwriteOperation {
      case .overwrite:
        pop()
      case .ignore:
        return
      }
    }

    if data.endIndex < data.capacity {
      data.append(element)
    } else {
      data[tail] = element
    }

    tail = increment(at: tail)
    internalCount += 1
  }

  /// 버퍼에서 첫 번째(head) 요소를 반환
  /// - 반환값: 버퍼가 빈 경우 nil, 그렇지 않는 경우 첫번째 요소 (제네릭 타입) 반환
  public var peek: T? {
    if isEmpty {
      return nil
    }

    return data[head]
  }

  /// 버퍼내 요소의 개수 반환
  public var count: Int {
    return internalCount
  }

  /// 버퍼의 용량을 반환 또는 변경
  public var capacity: Int {
    return data.capacity
  }

  /// 현재 버퍼가 가득차있는지 확인
  /// - 가득차 있는 경우, true 반환
  /// - 그렇지 않는 경우, false 반환
  public var isFull: Bool {
    return count == data.capacity
  }

  /// 현재 큐의 요소가 공상태(비어있는지) 유무 반환
  /// - 비어있는 경우, true 반환
  /// - 비어있지 않는 경우, false 반환
  public var isEmpty: Bool {
    return count < 1
  }

  /// 포인터 값을 1씩 증가시킴
  /// - Warning: 이 메소드는 증가된 값이 배열의 마지막 요소를 넘을 경우를 대비해야 함
  fileprivate func increment(at pointer: Int) -> Int {
    return (pointer + 1) & (data.capacity - 1)
  }
}

// MARK: - CustomStringConvertible

extension CircularBuffer: CustomStringConvertible {
  public var description: String {

    var list = [String]()
    for (idx, element) in data.enumerated() {
      if head == idx && tail == idx {
        list.append("\(element)([head, tail])")
      } else if head == idx {
        list.append("\(element)([head])")
      } else if tail == idx {
        list.append("\(element)([tail])")
      } else {
        list.append("\(element)")
      }
    }

    return list.joined(separator: ", ")
  }

}

// MARK: - ExpressibleByArrayLiteral

extension CircularBuffer: ExpressibleByArrayLiteral {
  // 배열 리터널로 CircularBuffer 초기화
  public init(arrayLiteral elements: T...) {
    self.init(elements, count: elements.count)
  }
}

// MARK: - Sequence

extension CircularBuffer: Sequence {
  /// 시퀀스 요소를 순회한 뒤 Iteractor로 반환
  /// - 복잡성: O(n)
  public func makeIterator() -> AnyIterator<T> {
    var newData = [T]()
    var copyBuffer = self

    while copyBuffer.peek != nil {
      if let element = copyBuffer.pop() {
        newData.append(element)
      }
    }

    return AnyIterator(IndexingIterator(_elements: newData.lazy))
  }
}
