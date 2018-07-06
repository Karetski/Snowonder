//
//  Comparator.swift
//  ImportArtisan
//
//  Created by Aliaksei Karetski on 7/6/18.
//  Copyright © 2018 Karetski. All rights reserved.
//

import Foundation

public struct Comparator<Item> {
    public enum Error: Swift.Error {
        case same
    }

    public typealias ComparisonResultProvider<Item> = (Item, Item) throws -> Bool
    public typealias ParameterProvider<Item, Parameter : Comparable> = (Item) -> Parameter

    public let areInIncreasingOrder: ComparisonResultProvider<Item>

    public init(_ areInIncreasingOrder: @escaping ComparisonResultProvider<Item>) {
        self.areInIncreasingOrder = areInIncreasingOrder
    }

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
    public func sorted(by comparator: Comparator<Iterator.Element>) -> [Iterator.Element] {
        return self.sorted { left, right in
            return (try? comparator.areInIncreasingOrder(left, right)) ?? false
        }
    }
}
