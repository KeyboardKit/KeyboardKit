//
//  KeyboardLayout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/// This type defines the full set of keys on a keyboard and
/// serves as a namespace for layout-related types.
///
/// A layout also specifies sizes, alignments, etc. which is
/// required information when rendering a keyboard.
///
/// You can use the ``itemRows`` property to modify a layout,
/// e.g. with the various insert, replace & remove functions.
public class KeyboardLayout {

    /// Create a new layout with the provided items.
    ///
    /// - Parameters:
    ///   - itemRows: The items to add to the keyboard.
    ///   - iPadProLayout: Whether the layout is iPad Pro specific.
    ///   - idealItemHeight: An optional, ideal item height, otherwise picked from the first item.
    ///   - idealItemInsets: An optional, ideal item inset value, otherwise picked from the first item.
    public init(
        itemRows rows: ItemRows,
        iPadProLayout: Bool = false,
        idealItemHeight height: Double? = nil,
        idealItemInsets insets: EdgeInsets? = nil
    ) {
        self.itemRows = rows
        self.ipadProLayout = iPadProLayout
        self.idealItemHeight = height ?? Self.resolveIdealItemHeight(for: rows)
        self.idealItemInsets = insets ?? Self.resolveIdealItemInsets(for: rows)
    }

    /// The layout item rows to show in the keyboard.
    public var itemRows: ItemRows

    /// The ideal item height.
    public var idealItemHeight: Double

    /// The ideal item inserts.
    public var idealItemInsets: EdgeInsets
    
    /// Whether this is an iPad Pro layout.
    public var ipadProLayout: Bool

    /// A `CGFloat` typealias for the total keyboard width.
    public typealias TotalWidth = CGFloat

    /// A cache used to avoid having to recalculate widths.
    var widthCache = [TotalWidth: CGFloat]()
}

public extension KeyboardLayout {
    
    /// Create a copy of the keyboard.
    func copy() -> KeyboardLayout {
        .init(
            itemRows: itemRows,
            iPadProLayout: ipadProLayout,
            idealItemHeight: idealItemHeight,
            idealItemInsets: idealItemInsets
        )
    }
}

private extension KeyboardLayout {

    static func resolveIdealItemHeight(
        for rows: KeyboardLayout.ItemRows
    ) -> Double {
        let item = rows.flatMap { $0 }.first
        return Double(item?.size.height ?? .zero)
    }

    static func resolveIdealItemInsets(
        for rows: KeyboardLayout.ItemRows
    ) -> EdgeInsets {
        let item = rows.flatMap { $0 }.first
        return item?.edgeInsets ?? EdgeInsets()
    }
}
