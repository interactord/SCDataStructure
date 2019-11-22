//
// Created by Scott Moon on 2019-08-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct PriorityQueue<T: Comparable> {

  fileprivate var heap = [T]()
  fileprivate let ordered: (T, T) -> Bool

  /// 초기화 메서드
  public init(ascending: Bool = false, startingValues: [T] = []) {
    ordered = ascending ? { $0 > $1 } : { $0 < $1 }
    heap = startingValues

    var idx = heap.count / 2 - 1
    while idx >= 0 {
      sink(idx)
      idx -= 1
    }
  }

  /// 우선 순위 큐의 요소의 개수 반환
  public var count: Int {
    return heap.count
  }

  /// 우선순위 큐가 빈 경우, true 를 반환
  public var isEmpty: Bool {
    return heap.isEmpty
  }

  /// 현재 최우선 순위 아이템을 검색하여 해당 요소를 반환, 만일 우선 순위 큐가 빈 경우 nil 반환
  /// - 복잡도: O(1)
  public var peek: T? {
    return heap.first
  }

  /// 우선순위 큐에 새 요소 추가
  /// - Parameter: element
  public mutating func push(_ element: T) {
    heap.append(element)
    swim(count - 1)
  }

  /// 최우선 순위를 제거하고 제거된 요소를 반환
  /// - Return Param: 큐의 최우선 순위를 요소 또는 우선 순위 큐가 비어있을 경우, nil 반환
  public mutating func pop() -> T? {
    if isEmpty {
      return nil
    }

    if count == 1 {
      return heap.removeFirst()
    }

    heap.swapAt(0, count - 1)
    let result = heap.removeLast()
    sink(0)

    return result
  }

  /// 특정 요소의 첫 번째로 반환되는 요소를 제거
  /// - Parameter: 삭제할 요소의 첫번째 아이템
  public mutating func remove(first item: T) {
    if let index = heap.firstIndex(of: item) {
      heap.swapAt(index, count - 1)
      heap.removeLast()
      swim(index)
      sink(index)
    }
  }

  /// 특정 아이템의 모든 반환 요소삭제
  /// - Parameter: 삭제할 요소의 아이템
  public mutating func remove(all item: T) {
    var lastCount = count
    remove(first: item)
    while count < lastCount {
      lastCount = count
      remove(first: item)
    }
  }

  /// 우선순위 큐에 모든 요소제거
  public mutating func clear() {
    heap.removeAll()
  }

  /// 부모노드의 값과 비교하여 자리를 교체하면서 아래로 이동
  /// 맨 하단부터 상단 트리로 검사하면서, 교체함
  public mutating func sink(_ index: Int) {
    var index = index

    while 2 * index + 1 < heap.count {

      /// `j` 는 오른쪽 노드의 자식
      var j = 2 * index + 1
      if j < (heap.count - 1) && ordered(heap[j], heap[j + 1]) {
        j += 1
      }
      if !ordered(heap[index], heap[j]) {
        break
      }

      heap.swapAt(index, j)
      index = j
    }
  }

  /// 부모노드와 자식노드간의 위치 교체
  public mutating func swim(_ index: Int) {
    var index = index
    while index > 0 && ordered(heap[(index - 1) / 2], heap[index]) {
      heap.swapAt((index - 1) / 2, index)
      index = (index - 1) / 2
    }
  }

}

// MARK: - CustomStringConvertible, CustomDebugStringConvertible

extension PriorityQueue: CustomStringConvertible, CustomDebugStringConvertible {

  public var description: String {
    return heap.description
  }

  public var debugDescription: String {
    return heap.debugDescription
  }

}

// MARK: - IteratorProtocol

extension PriorityQueue: IteratorProtocol {

  public mutating func next() -> T? {
    return pop()
  }

}

// MARK: - Sequence

extension PriorityQueue: Sequence {

  public func makeIterator() -> PriorityQueue {
    return self
  }

}

// MARK: - Collection

extension PriorityQueue: Collection {

  public typealias Index = Int

  public var startIndex: Int {
    return heap.startIndex
  }

  public var endIndex: Int {
    return heap.endIndex
  }

  public subscript(i: Int) -> T {
    return heap[i]
  }

  public func index(after i: PriorityQueue.Index) -> PriorityQueue.Index {
    return heap.index(after: i)
  }

}
