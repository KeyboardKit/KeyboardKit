//
//  KeyboardLayout+BottomRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {
    
    /// Get the bottom row, if any.
    var bottomRow: KeyboardLayout.ItemRow? {
        itemRow(at: bottomRowIndex)
    }
    
    /// Get the bottom item row index.
    var bottomRowIndex: Int {
        itemRows.count - 1
    }
    
    /// Get the bottom row-only layout.
    var bottomRowLayout: KeyboardLayout {
        let layout = self
        layout.itemRows = layout.itemRows.suffix(1)
        return layout
    }
    
    /// Get the bottom row's system action items, if any.
    var bottomRowSystemItems: [KeyboardLayout.Item]? {
        bottomRow?.filter { $0.action.isSystemAction }
    }
    
    /// Get the bottom row's system item width, if any.
    var bottomRowSystemItemWidth: KeyboardLayout.ItemWidth? {
        bottomRowSystemItems?.first?.size.width
    }

    /// Try to create a bottom row item.
    ///
    /// This uses the first ``bottomRowSystemItems`` item as
    /// template, if any. Otherwise, it takes first item. If
    /// the row is empty, the function returns `nil`.
    func tryCreateBottomRowItem(
        for action: KeyboardAction,
        size: KeyboardLayout.ItemSize? = nil
    ) -> KeyboardLayout.Item? {
        let item = bottomRowSystemItems?.first ?? bottomRow?.first
        guard let template = item else { return nil }
        return KeyboardLayout.Item(
            action: action,
            size: size ?? template.size,
            edgeInsets: template.edgeInsets
        )
    }
    
    /// Try to insert a certain action into the bottom row.
    func tryInsertBottomRowAction(
        _ new: KeyboardAction,
        before action: KeyboardAction,
        size: KeyboardLayout.ItemSize? = nil
    ) {
        guard let item = tryCreateBottomRowItem(
            for: new,
            size: size
        ) else { return }
        itemRows.insert(item, before: action, atRow: bottomRowIndex)
    }
    
    /// Try to insert a certain action into the bottom row.
    func tryInsertBottomRowAction(
        _ new: KeyboardAction,
        after action: KeyboardAction,
        size: KeyboardLayout.ItemSize? = nil
    ) {
        guard let item = tryCreateBottomRowItem(
            for: new,
            size: size
        ) else { return }
        itemRows.insert(item, after: action, atRow: bottomRowIndex)
    }
    
    /// Try to replace a certain action in the bottom row.
    func tryReplaceBottomRowAction(
        _ action: KeyboardAction,
        with newAction: KeyboardAction,
        size: KeyboardLayout.ItemSize? = nil
    ) {
        guard let item = tryCreateBottomRowItem(
            for: newAction,
            size: size
        ) else { return }
        itemRows.replace(action, with: item, atRow: bottomRowIndex)
    }
}
