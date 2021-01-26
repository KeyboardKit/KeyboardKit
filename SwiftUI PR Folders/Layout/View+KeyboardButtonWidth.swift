//
//  View+KeyboardButtonWidth.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-21.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Apply a certain keybard button width type to this view.
     
     You only have to provide a `totalWidth` for `percentage`
     and `reference`s that are based on `percentage`.
     
     You only have to provide a `referenceSize` binding when
     you use `reference` or `fromReference`. The binding can
     just be a state in the parent view.
     */
    @ViewBuilder
    func width(_ width: KeyboardButtonWidth, totalWidth: CGFloat = .zero, referenceSize: Binding<CGSize> = .constant(.zero)) -> some View {
        switch width {
        case .fromReference: self.frame(width: referenceSize.width.wrappedValue)
        case .fixed(let points): self.frame(width: points)
        case .percentage(let percent): self.frame(width: percent * totalWidth)
        case .reference(let width): self.frame(width: self.width(for: width, totalWidth: totalWidth, referenceSize: referenceSize.wrappedValue)).bindSize(to: referenceSize)
        case .available: self
        }
    }
}

private extension View {
    
    /**
     Calculate the width in points for a certain width type.
     */
    func width(for width: KeyboardButtonWidth, totalWidth: CGFloat, referenceSize: CGSize) -> CGFloat? {
        switch width {
        case .fixed(let points): return points
        case .percentage(let percent): return percent * totalWidth
        case .available: return nil
        default: return 0
        }
    }
}
