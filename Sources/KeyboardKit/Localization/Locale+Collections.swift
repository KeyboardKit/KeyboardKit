//
//  Locale+Collections.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-09.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Collection where Element == Locale {

    /// Insert a certain a locale first in the collection.
    func insertingFirst(_ locale: Element) -> [Element] {
        [locale] + removing(locale)
    }

    /// Remove a certain a locale from the collection.
    func removing(_ locale: Element) -> [Element] {
        filter { $0 != locale }
    }

    /// Sort the collection by the localized item name, then
    /// optionally place a locale first.
    ///
    /// - Parameters:
    ///   - first: The locale to place first, by default `nil`.
    func sorted(
        insertFirst first: Element? = nil
    ) -> [Element] {
        sorted(by: {
            let lhs = $0.localizedName?.lowercased() ?? ""
            let rhs = $1.localizedName?.lowercased() ?? ""
            return lhs < rhs
        }, insertFirst: first)
    }

    /// Sort the collection by the localized item name for a
    /// certain locale, then optionally place a locale first.
    ///
    /// - Parameters:
    ///   - locale: The locale to use to get the localized name.
    ///   - first: The locale to place first, by default `nil`.
    func sorted(
        in locale: Locale,
        insertFirst first: Element? = nil
    ) -> [Element] {
        sorted(by: {
            let lhs = $0.localizedName(in: locale)?.lowercased() ?? ""
            let rhs = $1.localizedName(in: locale)?.lowercased() ?? ""
            return lhs < rhs
        }, insertFirst: first)
    }

    /// Sort the collection by a sort comparator, then place
    /// a locale first in the sorted result.
    ///
    /// - Parameters:
    ///   - comparator: The sort comparator to use.
    ///   - first: The locale to place first, by default `nil`.
    func sorted(
        by comparator: (Element, Element) -> Bool,
        insertFirst first: Element?
    ) -> [Element] {
        let sorted = self.sorted(by: comparator)
        guard let first else { return sorted }
        return sorted.insertingFirst(first)
    }
}
