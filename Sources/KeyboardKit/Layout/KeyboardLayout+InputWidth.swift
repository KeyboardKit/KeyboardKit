//
//  KeyboardLayout+InputWidth.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {
    
    /**
     Calculate the width of an input key given a `totalWidth`.

     This will find the smallest required input width in all
     rows, which can then be applied to all input keys.
     */
    func inputWidth(
        for totalWidth: TotalWidth
    ) -> CGFloat {
        if let result = widthCache[totalWidth] { return result }
        let result = itemRows.inputWidth(for: totalWidth)
        widthCache[totalWidth] = result
        return result
    }
}

public extension KeyboardLayout.ItemRows {
    
    /// The width to apply to input keys given a total width.
    func inputWidth(
        for totalWidth: CGFloat
    ) -> CGFloat {
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
