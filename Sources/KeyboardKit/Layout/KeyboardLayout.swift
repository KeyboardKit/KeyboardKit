//
//  KeyboardLayout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 A keyboard layout lists all available actions on a keyboard
 as well as their size.
 
 A keyboard layout most often consists of several input rows
 where the input buttons are surrounded by system buttons on
 either or both sides, as well as a bottom row, with a large
 space button and several system buttons.
 
 A keyboard layout can however be entirely custom. Implement
 a custom `KeyboardLayoutProvider` to create your own layout.
 */
public class KeyboardLayout {
    
    /**
     Create a new layout with the provided `items`.
     
     - Parameters:
       - items: The layout item rows to show in the keyboard.
    */
    public init(items: KeyboardLayoutItemRows) {
        self.items = items
    }
    
    /**
     The layout item rows to show in the keyboard.
     */
    public let items: KeyboardLayoutItemRows
    
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
     rows, which can then be applied to all input keys.
     */
    public func inputWidth(for totalWidth: TotalWidth) -> CGFloat {
        if let result = widthCache[totalWidth] { return result }
        let result = items.compactMap { $0.inputWidth(for: totalWidth) }.min() ?? 0
        widthCache[totalWidth] = result
        return result
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
