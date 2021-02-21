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
