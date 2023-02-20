//
//  KeyboardLayout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 A keyboard layout defines all available keyboard actions on
 a keyboard, as well as their size.
 
 A keyboard layout most often consists of several input rows
 where the input buttons are surrounded by system buttons on
 either or both sides, as well as a bottom row, with a large
 space button and several system buttons.
 
 The most flexible way to generate a keyboard layout is with
 a ``KeyboardLayoutProvider``.
 */
public class KeyboardLayout {
    
    /**
     Create a new layout with the provided `items`.
     
     - Parameters:
       - itemRows: The layout item rows to show in the keyboard.
       - idealItemHeight: An optional, ideal item height, otherwise picked from the first item.
       - idealItemInsets: An optional, ideal item inset value, otherwise picked from the first item.
    */
    public init(
        itemRows rows: KeyboardLayoutItemRows,
        idealItemHeight height: Double? = nil,
        idealItemInsets insets: EdgeInsets? = nil
    ) {
        self.itemRows = rows
        self.idealItemHeight = height ?? Self.resolveIdealItemHeight(for: rows)
        self.idealItemInsets = insets ?? Self.resolveIdealItemInsets(for: rows)
    }
    
    /**
     The layout item rows to show in the keyboard.
     */
    public var itemRows: KeyboardLayoutItemRows

    /**
     The ideal item height, which can be used if you want to
     quickly add new items to the layout.
     */
    public var idealItemHeight: Double

    /**
     The ideal item inserts. This can be used if you want to
     quickly add new items to the layout.
     */
    public var idealItemInsets: EdgeInsets
    
    /**
     This `CGFloat` typealias makes it easier to see where a
     total width is expected.
     */
    public typealias TotalWidth = CGFloat
    
    /**
     This cache is used to avoid having to recalculate width
     information over and over.
     */
    var widthCache = [TotalWidth: CGFloat]()

    /**
     Calculate the width of an input key given a `totalWidth`.
     
     This will find the smallest required input width in all
     rows, which can then be applied to all input keys. This
     value will then be cached for the `totalWidth`, so that
     it doesn't have to be calculated again.
     */
    public func inputWidth(for totalWidth: TotalWidth) -> CGFloat {
        if let result = widthCache[totalWidth] { return result }
        let result = itemRows.compactMap { $0.inputWidth(for: totalWidth) }.min() ?? 0
        widthCache[totalWidth] = result
        return result
    }
}

private extension KeyboardLayout {

    static func resolveIdealItemHeight(for rows: KeyboardLayoutItemRows) -> Double {
        let item = rows.flatMap { $0 }.first
        return Double(item?.size.height ?? .zero)
    }

    static func resolveIdealItemInsets(for rows: KeyboardLayoutItemRows) -> EdgeInsets {
        let item = rows.flatMap { $0 }.first
        return item?.insets ?? EdgeInsets()
    }
}

private extension KeyboardLayoutItemRow {
    
    var hasInputWidth: Bool {
        contains { $0.size.width == .input }
    }
    
    func inputWidth(for totalWidth: CGFloat) -> CGFloat? {
        guard hasInputWidth else { return nil }
        let taken = reduce(0) { $0 + $1.allocatedWidth(for: totalWidth) }
        let remaining = totalWidth - taken
        let totalRefPercentage = reduce(0) { $0 + $1.inputPercentageFactor }
        return remaining / totalRefPercentage
    }
}

private extension KeyboardLayoutItem {
    
    func allocatedWidth(for totalWidth: CGFloat) -> CGFloat {
        switch size.width {
        case .available: return 0
        case .input: return 0
        case .inputPercentage: return 0
        case .percentage(let percentage): return totalWidth * percentage
        case .points(let points): return points
        }
    }
    
    var inputPercentageFactor: CGFloat {
        switch size.width {
        case .available: return 0
        case .input: return 1
        case .inputPercentage(let percentage): return percentage
        case .percentage: return 0
        case .points: return 0
        }
    }
}
