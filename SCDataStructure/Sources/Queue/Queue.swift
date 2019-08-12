//
// Created by Scott Moon on 2019-08-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct Queue<T> {

  private var data = [T]()

  public init() { }

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
