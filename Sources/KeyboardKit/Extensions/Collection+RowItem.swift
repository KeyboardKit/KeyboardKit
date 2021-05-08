//
//  RowItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that is stored
 in "rows" that should be easily mutated.
 
 The reason to why not using `Identifiable` instead, is that
 the row ID may not be unique. The same item may appear many
 times in the same row.
 */
public protocol RowItem {
    
    associatedtype ID: Equatable
    
    /**
     An ID that identifies the item in a row. Note that this
     is not necessarily unique.
     */
    var rowId: ID { get }
}

/**
 This extension contains mutating functions for arrays where
 the elements are `RowItem`s. It is used to get the same api
 for all row types.
 
 Note that the `insert` and `remove` operations will use the
 first index found. If the same id appears many times at one
 row, pick an adjacent id instead.
 */
public extension RangeReplaceableCollection where Element: RowItem, Index == Int {
    
    func index(of id: Element.ID) -> Index? {
        firstIndex { $0.rowId == id }
    }
    
    mutating func insert(_ item: Element, after id: Element.ID) {
        guard let index = index(of: id) else { return }
        insert(item, at: index.advanced(by: 1))
    }
    
    mutating func insert(_ item: Element, before id: Element.ID) {
        guard let index = index(of: id) else { return }
        insert(item, at: index)
    }
    
    mutating func remove(_ item: Element) {
        remove(item.rowId)
    }
    
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
    
    func row(at index: Int) -> Element? {
        guard index >= 0, count > index else { return nil }
        return self[index]
    }
    
    mutating func insert(_ item: Element.Element, after action: Element.Element.ID, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.insert(item, after: action)
        self[index] = row
    }
    
    mutating func insert(_ item: Element.Element, before action: Element.Element.ID, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.insert(item, before: action)
        self[index] = row
    }
    
    mutating func remove(_ item: Element.Element, atRow index: Int) {
        remove(item.rowId, atRow: index)
    }
    
    mutating func remove(_ id: Element.Element.ID, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.remove(id)
        self[index] = row
    }
}
