//
// Created by Scott Moon on 2019-08-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct Queue<T> {

  private var data = [T]()

  public init() { }

  /// 시쿼스 타입 이니셜 라이징
  public init<S: Sequence>(_ element: S) where S.Iterator.Element == T {
    data.append(contentsOf: element)
  }

  /// 큐에서 첫번째 요소를 제거하고 반환
  /// - 반환값:
  /// - 큐의 요소가 빈 경우, nil
  /// - 큐의 요소가 비어있지 않는 경우, 첫번째 요소 (제네릭 타입)
  public mutating func dequeue() -> T? {
    if data.first != nil {
      return data.removeFirst()
    }

    return nil

  }

  /// 큐의 첫번째 요소를 반환
  /// - 반환값:
  /// - 큐가 빈 경우, nil
  /// - 큐가 비어있지 않는 경우, 첫번째 요소 (제네릭 타입)
  public var peek: T? {
    return data.first
  }

  /// 큐의 맨 뒤에 요소를 추가
  /// - 복잡성 : O(1)
  /// - 매개변수: 제네릭 타입
  public mutating func enqueue(_ element: T) {
    data.append(element)
  }

  /// 큐의 요소를 빈요소로 변경
  public mutating func clear() {
    data.removeAll()
  }

  /// 큐의 요소의 개수 반환
  public var count: Int {
    return data.count
  }

  /// 현재 큐의 요소가 공상태(비어있는지) 유무 반환
  /// - 비어있는 경우, true 반환
  /// - 비어있지 않는 경우, false 반환
  public var isEmpty: Bool {
    return data.isEmpty
  }

}

// MARK: - CustomDebugStringConvertible, CustomStringConvertible
/// 큐의의 요소 String 타입으로 출력하기 위한 프로토콜 구현
extension Queue: CustomDebugStringConvertible, CustomStringConvertible {

  public var debugDescription: String {
    return data.debugDescription
  }
  public var description: String {
    return data.description
  }
}

// MARK: - ExpressibleByArrayLiteral
/// List 타입의 배열 초기화를 사용하기 위한 프로토콜 구현
extension Queue: ExpressibleByArrayLiteral {

  public init(arrayLiteral elements: T...) {
    self.init(elements)
  }

}

// MARK: - Sequence
/// 반복기(Iterator)를 사용하기 위한 프로토콜 구현
/// 복잡도: O(1)
extension Queue: Sequence {
  public func makeIterator() -> AnyIterator<T> {
    return AnyIterator(
      IndexingIterator(_elements: data.lazy)
    )
  }
}

// MARK: - MutableCollection
/// 서버스크립트를 사용하여, 특정 인덱스 값을 조회 또는 변경이 가능하기 위한 프로토콜 구현
extension Queue: MutableCollection {
  public var startIndex: Int {
    return 0
  }

  public var endIndex: Int {
    return count - 1
  }

  public func index(after i: Int) -> Int {
    return data.index(after: i)
  }

  public subscript(index: Int) -> T {
    get {
      return data[index]
    }
    set {
      data[index] = newValue
    }
  }

}
