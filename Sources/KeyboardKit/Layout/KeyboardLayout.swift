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
 Keyboard layouts list available actions on a keyboard. They
 most often consist of multiple input button rows surrounded
 by system buttons, as well as size information.
 */
public class KeyboardLayout {
    
    public init(items: KeyboardLayoutItemRows) {
        self.items = items
    }
    
    public let items: KeyboardLayoutItemRows
    
    public typealias TotalWidth = CGFloat
    
    var widthCache = [TotalWidth: CGFloat]()
    
    public func inputWidth(for totalWidth: TotalWidth) -> CGFloat {
        if let result = widthCache[totalWidth] { return result }
        let result = items.compactMap { $0.referenceWidth(for: totalWidth) }.min() ?? 0
        widthCache[totalWidth] = result
        return result
    }
}

private extension KeyboardLayoutItemRow {
    
    var hasInputWidth: Bool {
        contains { $0.size.width == .input }
    }
    
    func referenceWidth(for totalWidth: CGFloat) -> CGFloat? {
        guard hasInputWidth else { return nil }
        let taken = reduce(0) { $0 + $1.allocatedWidth(for: totalWidth) }
        let remaining = totalWidth - taken
        let totalRefPercentage = reduce(0) { $0 + $1.referencePercentage }
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
    
    var referencePercentage: CGFloat {
        switch size.width {
        case .available: return 0
        case .input: return 1
        case .inputPercentage(let percentage): return percentage
        case .percentage: return 0
        case .points: return 0
        }
    }
}
