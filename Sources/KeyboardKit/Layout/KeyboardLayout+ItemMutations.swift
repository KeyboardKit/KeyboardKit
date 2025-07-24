//
//  KeyboardLayout+ItemMutation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-08.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

// MARK: - ItemRow

public extension RangeReplaceableCollection where Element == KeyboardLayout.Item, Index == Int {

    /// Get the index of a certain `action`.
    func index(
        of action: KeyboardAction
    ) -> Index? {
        firstIndex { $0.action == action }
    }

    /// Insert a layout `item` before a certain `action`.
    mutating func insert(
        _ item: Element,
        before action: KeyboardAction
    ) {
        guard let index = index(of: action) else { return }
        insert(item, at: index)
    }

    /// Insert an layout `item` after a certain `action`.
    mutating func insert(
        _ item: Element,
        after action: KeyboardAction
    ) {
        guard let index = index(of: action) else { return }
        insert(item, at: index.advanced(by: 1))
    }

    /// Remove a certain `action`.
    mutating func remove(
        _ action: KeyboardAction
    ) {
        while let index = index(of: action) {
            remove(at: index)
        }
    }

    /// Remove all items that meet a certain `condition`.
    mutating func remove(
        where condition: (Element) -> Bool
    ) {
        while let index = firstIndex(where: condition) {
            remove(at: index)
        }
    }

    /// Replace a certain `action` with a replacement `item`.
    mutating func replace(
        _ action: KeyboardAction,
        with item: Element
    ) {
        guard let index = index(of: action) else { return }
        insert(item, after: action)
        remove(at: index)
    }
}


// MARK: - ItemRows

public extension Array where Element: RangeReplaceableCollection,
                             Element.Index == Int,
                             Element.Element == KeyboardLayout.Item {

    /// Get the row at a certain index.
    func row(
        at rowIndex: Int
    ) -> Element? {
        guard rowIndex >= 0, count > rowIndex else { return nil }
        return self[rowIndex]
    }

    /// Insert an `item` before an `action` in all rows.
    mutating func insert(
        _ item: Element.Element,
        before action: KeyboardAction
    ) {
        enumerated().forEach {
            insert(item, before: action, inRow: $0.offset)
        }
    }

    /// Insert an `item` before an `action` in a certain row.
    mutating func insert(
        _ item: Element.Element,
        before action: KeyboardAction,
        inRow rowIndex: Int
    ) {
        guard var row = self.row(at: rowIndex) else { return }
        row.insert(item, before: action)
        self[rowIndex] = row
    }

    /// Insert an `item` after an `action` in all rows.
    mutating func insert(
        _ item: Element.Element,
        after action: KeyboardAction
    ) {
        enumerated().forEach {
            insert(item, after: action, inRow: $0.offset)
        }
    }

    /// Insert an `item` after an `action` in a certain row.
    mutating func insert(
        _ item: Element.Element,
        after action: KeyboardAction,
        inRow rowIndex: Int
    ) {
        guard var row = self.row(at: rowIndex) else { return }
        row.insert(item, after: action)
        self[rowIndex] = row
    }

    /// Remove a certain `action` from all rows.
    mutating func remove(
        _ action: KeyboardAction
    ) {
        enumerated().forEach {
            remove(action, fromRow: $0.offset)
        }
    }

    /// Remove a certain `action` from a certain row.
    mutating func remove(
        _ action: KeyboardAction,
        fromRow rowIndex: Int
    ) {
        guard var row = self.row(at: rowIndex) else { return }
        row.remove(action)
        self[rowIndex] = row
    }

    /// Remove all items that meet a `condition` in all rows.
    mutating func remove(
        where condition: (Element.Element) -> Bool
    ) {
        enumerated().forEach {
            remove(where: condition, fromRow: $0.offset)
        }
    }

    /// Remove all items that meet a `condition` from a row.
    mutating func remove(
        where condition: (Element.Element) -> Bool,
        fromRow rowIndex: Int
    ) {
        guard var row = self.row(at: rowIndex) else { return }
        row.remove(where: condition)
        self[rowIndex] = row
    }

    /// Replace an `action` with another `item` in all rows.
    mutating func replace(
        _ action: KeyboardAction,
        with replacement: Element.Element
    ) {
        enumerated().forEach {
            replace(action, with: replacement, inRow: $0.offset)
        }
    }

    /// Replace an action with another item in a certain row.
    mutating func replace(
        _ action: KeyboardAction,
        with replacement: Element.Element,
        inRow rowIndex: Int
    ) {
        guard var row = self.row(at: rowIndex) else { return }
        row.replace(action, with: replacement)
        self[rowIndex] = row
    }
}
