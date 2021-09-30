//
//  View+Callout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.

import SwiftUI

public extension View {
    
    /**
     Apply a callout shadow, using the provided `style`.
     */
    func calloutShadow(style: CalloutStyle) -> some View {
        self.shadow(color: style.borderColor, radius: 0.4)
            .shadow(color: style.shadowColor, radius: style.shadowRadius)
    }
}
