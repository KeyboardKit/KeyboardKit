//
//  KeyboardLayoutItemRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This typealias represents a list of layout items.
 */
public typealias KeyboardLayoutItemRow = [KeyboardLayoutItem]

public extension KeyboardLayoutItemRow {
    
    func index(of action: KeyboardAction) -> Index? {
        firstIndex { $0.action == action }
    }
    
    mutating func insert(_ item: KeyboardLayoutItem, after action: KeyboardAction) {
        guard let index = index(of: action) else { return }
        insert(item, at: index.advanced(by: 1))
    }
    
    mutating func insert(_ item: KeyboardLayoutItem, before action: KeyboardAction) {
        guard let index = index(of: action) else { return }
        insert(item, at: index)
    }
}

/**
 This typealias represents a list of layout item rows.
 */
public typealias KeyboardLayoutItemRows = [KeyboardLayoutItemRow]

public extension KeyboardLayoutItemRows {
    
    func row(at index: Int) -> KeyboardLayoutItemRow? {
        guard index >= 0, count > index else { return nil }
        return self[index]
    }
    
    mutating func insert(_ item: KeyboardLayoutItem, after action: KeyboardAction, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.insert(item, after: action)
        self[index] = row
    }
    
    mutating func insert(_ item: KeyboardLayoutItem, before action: KeyboardAction, atRow index: Int) {
        guard var row = self.row(at: index) else { return }
        row.insert(item, before: action)
        self[index] = row
    }
}
