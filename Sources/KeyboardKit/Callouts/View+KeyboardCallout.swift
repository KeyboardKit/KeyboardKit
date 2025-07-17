//
//  View+Callouts.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Setup the view as a keyboard callout container.
    ///
    /// - Parameters:
    ///   - calloutContext: The callout context to use.
    ///   - keyboardContext: The keyboard context to use.
    func keyboardCalloutContainer(
        calloutContext: KeyboardCalloutContext,
        keyboardContext: KeyboardContext
    ) -> some View {
        self.keyboardActionCalloutContainer(
            calloutContext: calloutContext,
            keyboardContext: keyboardContext
        )
        .keyboardInputCalloutContainer(
            calloutContext: calloutContext,
            keyboardContext: keyboardContext
        )
    }
}

extension View {

    func keyboardCalloutShadow(
        style: Callouts.CalloutStyle = .standard
    ) -> some View {
        self.shadow(color: style.borderColor, radius: 0.4)
            .shadow(color: style.shadowColor, radius: style.shadowRadius)
    }

    func keyboardActionCalloutContainer(
        calloutContext: KeyboardCalloutContext,
        keyboardContext: KeyboardContext
    ) -> some View {
        self.overlay(
            Callouts.ActionCallout(
                calloutContext: calloutContext,
                keyboardContext: keyboardContext
            )
            .environment(\.emojiKeyboardStyle, { .standard(for: $0) })
        )
        .coordinateSpace(name: calloutContext.coordinateSpace)
    }

    func keyboardInputCalloutContainer(
        calloutContext: KeyboardCalloutContext,
        keyboardContext: KeyboardContext
    ) -> some View {
        self.overlay(
            Callouts.InputCallout(
                calloutContext: calloutContext,
                keyboardContext: keyboardContext
            )
        )
        .coordinateSpace(name: calloutContext.coordinateSpace)
    }
}
