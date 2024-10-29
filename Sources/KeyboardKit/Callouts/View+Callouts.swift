//
//  View+Callouts.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Setup the view as a keyboard callout container.
    ///
    /// - Parameters:
    ///   - calloutContext: The callout context to use.
    ///   - keyboardContext: The keyboard context to use.
    func keyboardCalloutContainer(
        calloutContext: CalloutContext,
        keyboardContext: KeyboardContext
    ) -> some View {
        self.keyboardActionCalloutContainer(
            calloutContext: calloutContext.actionContext,
            keyboardContext: keyboardContext
        )
        .keyboardInputCalloutContainer(
            calloutContext: calloutContext.inputContext,
            keyboardContext: keyboardContext
        )
    }
}

extension View {

    /// Apply a keyboard callout shadow to the view.
    ///
    /// - Parameters:
    ///   - style: The style apply, by default `.standard`.
    func keyboardCalloutShadow(
        style: Callouts.CalloutStyle = .standard
    ) -> some View {
        self.shadow(color: style.borderColor, radius: 0.4)
            .shadow(color: style.shadowColor, radius: style.shadowRadius)
    }

    func keyboardActionCalloutContainer(
        calloutContext: CalloutContext.ActionContext,
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
        calloutContext: CalloutContext.InputContext,
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
