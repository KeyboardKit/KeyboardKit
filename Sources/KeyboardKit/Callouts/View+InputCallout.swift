//
//  View+InputCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     This modifier can be applied to any view that should be
     able to present an input callout.
     
     - Parameters:
       - calloutContext: The callout context to use.
       - keyboardContext: The keyboard context to use.
       - style: The style to apply to the view, by default `.standard`.
     */
    func inputCallout(
        calloutContext: InputCalloutContext,
        keyboardContext: KeyboardContext,
        style: InputCalloutStyle = .standard
    ) -> some View {
        ZStack {
            self
            InputCallout(
                calloutContext: calloutContext,
                keyboardContext: keyboardContext,
                style: style)
        }.coordinateSpace(name: InputCallout.coordinateSpace)
    }
}
