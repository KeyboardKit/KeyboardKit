//
//  RowItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This extension contains mutating functions for arrays where
 the elements are `RowItem`s. It is used to get the same api
 for all row types.
 
 Note that the `insert` and `remove` operations will use the
 first index found. If the same id appears many times at one
 row, pick an adjacent id instead.
 */
public extension RangeReplaceableCollection where Element: RowItem, Index == Int {
    
    /**
     Get the index of a certain element id, if any.
     */
    func index(of id: Element.ID) -> Index? {
        firstIndex { $0.rowId == id }
    }
    
    /**
     Insert an `item` after another item in the collection.
     */
    mutating func insert(_ item: Element, after id: Element.ID) {
        guard let index = index(of: id) else { return }
        insert(item, at: index.advanced(by: 1))
    }
    
    /**
     Insert an `item` before another item in the collection.
     */
    mutating func insert(_ item: Element, before id: Element.ID) {
        guard let index = index(of: id) else { return }
        insert(item, at: index)
    }
    
    /**
     Remove a certain `item` from the collection.
     */
    mutating func remove(_ item: Element) {
        remove(item.rowId)
    }
    
    /**
     Remove a certain item `id` from the collection.
     */
    mutating func remove(_ id: Element.ID) {
        while let index = index(of: id) {
            remove(at: index)
        }
    }
}

/**
 This extension contains mutating functions for arrays where
 the elements are `RowItem` lists. It's used to get the same
 api for all row collection types.
 
 Note that the `insert` and `remove` operations will use the
 first index found. If the same id appears many times at one
 row, pick an adjacent id instead.
 */
public extension Array where
Element: RangeReplaceableCollection,
Element.Index == Int,
Element.Element: RowItem {
    
    /**
     Get the row at a certain `index`.
     */
    func row(at index: Int) -> Element? {
        guard index >= 0, count > index else { return nil }
        return self[index]
    }
    
    /**
     Insert an `item` after another item on all rows.
     */
    mutating func insert(_ item: Element.Element, after action: Element.Element.ID) {
        enumerated().forEach {
            insert(item, after: action, atRow: $0.offset)
        }
    }
    
    /**
     Insert an `item` after another item on a certain row.
     */
    mutating func insert(_ item: Element.Element, after action: Element.Element.ID, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.insert(item, after: action)
        self[index] = row
    }
    
    /**
     Insert an `item` before another item on all rows.
     */
    mutating func insert(_ item: Element.Element, before action: Element.Element.ID) {
        enumerated().forEach {
            insert(item, before: action, atRow: $0.offset)
        }
    }
    
    /**
     Insert an `item` before another item on a certain row.
     */
    mutating func insert(_ item: Element.Element, before action: Element.Element.ID, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.insert(item, before: action)
        self[index] = row
    }
    
    /**
     Remove a certain `item` on all rows.
     */
    mutating func remove(_ item: Element.Element) {
        enumerated().forEach {
            remove(item.rowId, atRow: $0.offset)
        }
    }
    
    /**
     Remove a certain `item` at a certain row.
     */
    mutating func remove(_ item: Element.Element, atRow index: Int) {
        remove(item.rowId, atRow: index)
    }
    
    /**
     Remove a certain item `id` on all rows.
     */
    mutating func remove(_ id: Element.Element.ID) {
        enumerated().forEach {
            remove(id, atRow: $0.offset)
        }
    }
    
    /**
     Remove a certain item `id` at a certain row.
     */
    mutating func remove(_ id: Element.Element.ID, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.remove(id)
        self[index] = row
    }
}
