//
//  View+KeyboardLayoutWidth.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-21.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Apply a certain keyboard button width type to this view.
     
     The `totalWidth` parame is only required when using the
     `.percentage` and `.reference(.percentage)` width types.
     
     The `referenceSize` binding param is only required when
     using `.reference` and `.fromReference` width types.
     
     `TODO` Unit test these extensions.
     */
    @ViewBuilder
    func width(_ width: KeyboardLayoutWidth, totalWidth: CGFloat = .zero, referenceSize: Binding<CGSize> = .constant(.zero)) -> some View {
        switch width {
        case .available: self.frame(maxWidth: .infinity)
        case .percentage(let percent): self.frame(width: percent * totalWidth)
        case .points(let points): self.frame(width: points)
        case .reference: self.frame(maxWidth: .infinity).bindSize(to: referenceSize)
        case .useReference: self.frame(width: referenceSize.width.wrappedValue)
        case .useReferencePercentage(let percent): self.frame(width: percent * referenceSize.width.wrappedValue)
        }
    }
}
