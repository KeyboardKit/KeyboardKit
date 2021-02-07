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
     Apply a certain layout width to the view.
     
     The `referenceSize` parameter is the base width that is
     to be used by `.reference` and `.fromReference` widths.
     
     The `totalWidth` parameter is the total available width
     that is to be used by `.percentage` widths.
     
     `TODO` Unit test these extensions.
     */
    @ViewBuilder
    func width(_ width: KeyboardLayoutWidth, totalWidth: CGFloat, referenceWidth: CGFloat) -> some View {
        switch width {
        case .available: self.frame(maxWidth: .infinity)
        case .percentage(let percent): self.frame(width: percent * totalWidth)
        case .points(let points): self.frame(width: points)
        case .reference: self.frame(width: referenceWidth)
        case .useReference: self.frame(width: referenceWidth)
        case .useReferencePercentage(let percent): self.frame(width: percent * referenceWidth)
        }
    }
}
