//
//  RowItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-08.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This extension contains mutating functions for arrays where
 the elements implement ``KeyboardRowItem``.
 
 Note that the `insert` and `remove` operations will use the
 first index found. If the same id appears many times in one
 row, pick adjacent ids or use the before and after function
 variants.
 */
public extension RangeReplaceableCollection where Element: KeyboardRowItem, Index == Int {

    /**
     Get the index of a certain item, if any.
     */
    func index(of item: Element) -> Index? {
        index(of: item.rowId)
    }

    /**
     Get the index of a certain item id, if any.
     */
    func index(of id: Element.ID) -> Index? {
        firstIndex { $0.rowId == id }
    }

    /**
     Insert an item after another item.
     */
    mutating func insert(_ item: Element, after target: Element) {
        insert(item, after: target.rowId)
    }
    
    /**
     Insert an item after another item.
     */
    mutating func insert(_ item: Element, after id: Element.ID) {
        guard let index = index(of: id) else { return }
        insert(item, at: index.advanced(by: 1))
    }

    /**
     Insert an item before another item.
     */
    mutating func insert(_ item: Element, before target: Element) {
        insert(item, before: target.rowId)
    }
    
    /**
     Insert an item before another item.
     */
    mutating func insert(_ item: Element, before id: Element.ID) {
        guard let index = index(of: id) else { return }
        insert(item, at: index)
    }
    
    /**
     Remove a certain item.
     */
    mutating func remove(_ item: Element) {
        remove(item.rowId)
    }
    
    /**
     Remove a certain item.
     */
    mutating func remove(_ id: Element.ID) {
        while let index = index(of: id) {
            remove(at: index)
        }
    }

    /**
     Replace an item with another item.
     */
    mutating func replace(_ item: Element, with replacement: Element) {
        insert(replacement, after: item)
        remove(item)
    }

    /**
     Replace an item with another item.
     */
    mutating func replace(_ id: Element.ID, with replacement: Element) {
        guard let index = index(of: id) else { return }
        insert(replacement, after: id)
        remove(at: index)
    }
}

/**
 This extension contains mutating functions for arrays where
 the elements are ``KeyboardRowItem`` arrays.
 
 Note that the `insert` and `remove` operations will use the
 first index found. If the same id appears many times at one
 row, pick an adjacent id instead.
 */
public extension Array where
Element: RangeReplaceableCollection,
Element.Index == Int,
Element.Element: KeyboardRowItem {
    
    /**
     Get the row at a certain index.
     */
    func row(at index: Int) -> Element? {
        guard index >= 0, count > index else { return nil }
        return self[index]
    }

    /**
     Insert an item after another item in all rows.
     */
    mutating func insert(_ item: Element.Element, after target: Element.Element) {
        insert(item, after: target.rowId)
    }
    
    /**
     Insert an item after another item in all rows.
     */
    mutating func insert(_ item: Element.Element, after target: Element.Element.ID) {
        enumerated().forEach {
            insert(item, after: target, atRow: $0.offset)
        }
    }

    /**
     Insert an item after another item in a certain row.
     */
    mutating func insert(_ item: Element.Element, after target: Element.Element, atRow index: Int) {
        insert(item, after: target.rowId, atRow: index)
    }
    
    /**
     Insert an item after another item on a certain row.
     */
    mutating func insert(_ item: Element.Element, after target: Element.Element.ID, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.insert(item, after: target)
        self[index] = row
    }

    /**
     Insert an item before another item in all rows.
     */
    mutating func insert(_ item: Element.Element, before target: Element.Element) {
        insert(item, before: target.rowId)
    }
    
    /**
     Insert an item before another item in all rows.
     */
    mutating func insert(_ item: Element.Element, before target: Element.Element.ID) {
        enumerated().forEach {
            insert(item, before: target, atRow: $0.offset)
        }
    }

    /**
     Insert an item before another item in a certain row.
     */
    mutating func insert(_ item: Element.Element, before target: Element.Element, atRow index: Int) {
        insert(item, before: target.rowId, atRow: index)
    }
    
    /**
     Insert an item before another item in a certain row.
     */
    mutating func insert(_ item: Element.Element, before target: Element.Element.ID, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.insert(item, before: target)
        self[index] = row
    }
    
    /**
     Remove a certain item in all rows.
     */
    mutating func remove(_ item: Element.Element) {
        remove(item.rowId)
    }
    
    /**
     Remove a certain item item in all rows.
     */
    mutating func remove(_ id: Element.Element.ID) {
        enumerated().forEach {
            remove(id, atRow: $0.offset)
        }
    }

    /**
     Remove a certain item in a certain row.
     */
    mutating func remove(_ item: Element.Element, atRow index: Int) {
        remove(item.rowId, atRow: index)
    }

    /**
     Remove a certain item at a certain row.
     */
    mutating func remove(_ id: Element.Element.ID, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.remove(id)
        self[index] = row
    }

    /**
     Replace an item with another item in all rows.
     */
    mutating func replace(_ item: Element.Element, with replacement: Element.Element) {
        replace(item.rowId, with: replacement)
    }

    /**
     Replace an item with another item in all rows.
     */
    mutating func replace(_ item: Element.Element.ID, with replacement: Element.Element) {
        enumerated().forEach {
            replace(item, with: replacement, atRow: $0.offset)
        }
    }

    /**
     Replace an item with another item in a certain row.
     */
    mutating func replace(_ item: Element.Element, with replacement: Element.Element, atRow index: Int) {
        replace(item.rowId, with: replacement, atRow: index)
    }

    /**
     Replace an item with another item in a certain row.
     */
    mutating func replace(_ item: Element.Element.ID, with replacement: Element.Element, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.replace(item, with: replacement)
        self[index] = row
    }
}
