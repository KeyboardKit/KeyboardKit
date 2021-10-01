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
 This makes `KeyboardLayoutItem` conform to `RowItem`.
 */
extension KeyboardLayoutItem: RowItem {

    /**
     The row ID, which is used to identify the item in a row.
     
     Note that you can have multiple items with the same row
     ID in a row, but that will cause strange behaviors when
     you use operations for adding and removing items in the
     row, using the various convenience operations.
     */
    public var rowId: KeyboardAction { action }
}

/**
 This typealias represents a list of layout items.
 */
public typealias KeyboardLayoutItemRow = [KeyboardLayoutItem]

/**
 This typealias represents a list of layout item rows.
 
 The insert operations will use the first action found for a
 row. If the same action appears many times at one row, like
 the keyboard type shift on an iPad, pick an adjacent action.
 */
public typealias KeyboardLayoutItemRows = [KeyboardLayoutItemRow]
