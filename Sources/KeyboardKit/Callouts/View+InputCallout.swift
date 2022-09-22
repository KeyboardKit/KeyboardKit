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
       - context: The context to bind against.
       - keyboardContext: The keyboard context to use for contextual decisions.
       - style: The style to apply to the view, by default `.standard`.
     */
    func inputCallout(
        context: InputCalloutContext,
        keyboardContext: KeyboardContext,
        style: InputCalloutStyle = .standard
    ) -> some View {
        ZStack {
            self
            InputCallout(
                context: context,
                keyboardContext: keyboardContext,
                style: style)
        }.coordinateSpace(name: InputCallout.coordinateSpace)
    }
}
