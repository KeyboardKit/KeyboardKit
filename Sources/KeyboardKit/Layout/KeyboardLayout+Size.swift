//
//  KeyboardLayout+Size.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {
    
    /// The total height of the layout.
    var totalHeight: Double {
        itemRows.totalHeight
    }
    
    /// Calculate the input key width for a total width.
    ///
    /// This function will find the smallest, required input
    /// width in all rows, which can then be applied to each
    /// input key in the entire layout.
    func inputWidth(
        for totalWidth: TotalWidth
    ) -> Double {
        if let result = widthCache[totalWidth] { return result }
        let result = itemRows.inputWidth(for: totalWidth)
        widthCache[totalWidth] = result
        return result
    }
}

public extension KeyboardLayout.ItemRows {
    
    /// The total height of the layout.
    var totalHeight: Double {
        map {
            $0.compactMap { $0.size.height }.max() ?? 0
        }.reduce(0, +)
    }
    
    /// The width to apply to input keys given a total width.
    func inputWidth(
        for totalWidth: Double
    ) -> Double {
        compactMap {
            $0.suggestedInputWidth(for: totalWidth)
        }.min() ?? 0
    }
}

public extension KeyboardLayout.ItemRow {
    
    /// Whether or not the row has an input key.
    var hasInputKey: Bool {
        contains { $0.size.width == .input }
    }
    
    /// The row suggested input width, based on the its keys.
    func suggestedInputWidth(
        for totalWidth: CGFloat
    ) -> CGFloat? {
        guard hasInputKey else { return nil }
        let taken = reduce(0) { $0 + $1.allocatedWidth(for: totalWidth) }
        let remaining = totalWidth - taken
        let totalRefPercentage = reduce(0) { $0 + $1.inputPercentageFactor }
        return remaining / totalRefPercentage
    }
}

private extension KeyboardLayout.Item {

    func allocatedWidth(for totalWidth: CGFloat) -> CGFloat {
        switch size.width {
        case .available: 0
        case .input: 0
        case .inputPercentage: 0
        case .percentage(let percentage): totalWidth * percentage
        case .points(let points): points
        }
    }

    var inputPercentageFactor: CGFloat {
        switch size.width {
        case .available: 0
        case .input: 1
        case .inputPercentage(let percentage): percentage
        case .percentage: 0
        case .points: 0
        }
    }
}
