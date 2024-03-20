//
//  KeyboardLayout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/// A keyboard layout contains the full set of keyboard keys
/// that should be rendered for a keyboard.
///
/// A layout also specifies sizes, alignments, etc. which is
/// required information when rendering a keyboard.
public class KeyboardLayout {

    /// Create a new layout with the provided items.
    ///
    /// - Parameters:
    ///   - itemRows: The items to add to the keyboard.
    ///   - idealItemHeight: An optional, ideal item height, otherwise picked from the first item.
    ///   - idealItemInsets: An optional, ideal item inset value, otherwise picked from the first item.
    public init(
        itemRows rows: KeyboardLayout.ItemRows,
        idealItemHeight height: Double? = nil,
        idealItemInsets insets: EdgeInsets? = nil
    ) {
        self.itemRows = rows
        self.idealItemHeight = height ?? Self.resolveIdealItemHeight(for: rows)
        self.idealItemInsets = insets ?? Self.resolveIdealItemInsets(for: rows)
    }

    /// The layout item rows to show in the keyboard.
    public var itemRows: KeyboardLayout.ItemRows

    /// The ideal item height.
    public var idealItemHeight: Double

    /// The ideal item inserts.
    public var idealItemInsets: EdgeInsets

    /// A `CGFloat` typealias for the total keyboard width.
    public typealias TotalWidth = CGFloat
    
    /// Whether or not this is an iPad Pro layout.
    var ipadProLayout = false

    /// A cache used to avoid having to recalculate widths.
    var widthCache = [TotalWidth: CGFloat]()
}

private extension KeyboardLayout {

    static func resolveIdealItemHeight(for rows: KeyboardLayout.ItemRows) -> Double {
        let item = rows.flatMap { $0 }.first
        return Double(item?.size.height ?? .zero)
    }

    static func resolveIdealItemInsets(for rows: KeyboardLayout.ItemRows) -> EdgeInsets {
        let item = rows.flatMap { $0 }.first
        return item?.edgeInsets ?? EdgeInsets()
    }
}
