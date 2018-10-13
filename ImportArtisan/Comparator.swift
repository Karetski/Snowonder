//
//  Comparator.swift
//  ImportArtisan
//
//  Created by Aliaksei Karetski on 7/6/18.
//  Copyright © 2018 Karetski. All rights reserved.
//

/// Structure that describes compariton between items of type `Item` and contains various useful composing instruments.
public struct Comparator<Item> {
    public enum Error : Swift.Error {
        case same
    }

    public typealias ComparisonResultProvider<Item> = (Item, Item) throws -> Bool
    public typealias ParameterProvider<Item, Parameter : Comparable> = (Item) -> Parameter

    /// Closure that's been used to initialize comparator.
    public let areInIncreasingOrder: ComparisonResultProvider<Item>

    /// Creates `Comparator` instance using the given predicate as the comparison between elements.
    ///
    /// - Parameter areInIncreasingOrder: A predicate that returns true if its first argument should be ordered before its second argument; otherwise, false. If elements comparison result is same, then should throw `Comparator.Error.same`
    public init(_ areInIncreasingOrder: @escaping ComparisonResultProvider<Item>) {
        self.areInIncreasingOrder = areInIncreasingOrder
    }

    /// Composes multiple `Comparator` instances into chain by *left to right* principle.
    ///
    /// - Parameter comparators: Array of `Comparator` instances used to create the chain.
    public init(chain comparators: [Comparator<Item>]) {
        self.init { left, right in
            for comparator in comparators {
                guard let comparisonResult = try? comparator.areInIncreasingOrder(left, right) else {
                    continue
                }

                return comparisonResult
            }
            return false
        }
    }

    /// Creates `Comparator` instance using `isAscending` flag and `parameter` to compare
    ///
    /// - Parameters:
    ///   - isAscending: Flag that describes sorting direction.
    ///   - parameter: Closue used to get the parameter value.
    public init<Parameter : Comparable>(isAscending: Bool, parameter: @escaping ParameterProvider<Item, Parameter>) {
        self.init { left, right in
            let leftParameter = parameter(left)
            let rightParameter = parameter(right)

            guard leftParameter != rightParameter else {
                throw Error.same
            }

            return isAscending ? leftParameter < rightParameter : leftParameter > rightParameter
        }
    }
}

public extension Comparator {
    public func chaining(_ areInIncreasingOrder: @escaping ComparisonResultProvider<Item>) -> Comparator<Item> {
        return Comparator<Item>(chain: [self, Comparator<Item>(areInIncreasingOrder)])
    }

    public func chaining(_ comparator: Comparator<Item>) -> Comparator<Item> {
        return Comparator<Item>(chain: [self, comparator])
    }

    public func chaining(_ comparators: [Comparator<Item>]) -> Comparator<Item> {
        return Comparator<Item>(chain: [self] + comparators)
    }

    public func chaining<Parameter : Comparable>(isAscending: Bool, parameter: @escaping ParameterProvider<Item, Parameter>) -> Comparator<Item> {
        return Comparator<Item>(chain: [self, Comparator<Item>(isAscending: isAscending, parameter: parameter)])
    }
}

public extension Sequence {
    /// Returns the elements of the sequence, sorted using the given `Comparator`.
    ///
    /// - Parameter comparator: A `Comparator` that describes how elements should be compared during sorting.
    /// - Returns: Sorted array of sequence's elements.
    public func sorted(by comparator: Comparator<Iterator.Element>) -> [Iterator.Element] {
        return sorted { (try? comparator.areInIncreasingOrder($0, $1)) ?? false }
    }
}
