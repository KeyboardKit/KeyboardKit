//
//  View+Callouts.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Apply a keyboard action and input callout to the view.

     - Parameters:
       - calloutContext: The callout context to use.
       - keyboardContext: The keyboard context to use.
       - actionCalloutStyle: The action callout style to apply, by default ``KeyboardStyle/ActionCallout/standard``.
       - inputCalloutStyle: The action callout style to apply, by default ``KeyboardStyle/ActionCallout/standard``.
     */
    func keyboardCalloutContainer(
        calloutContext: CalloutContext,
        keyboardContext: KeyboardContext,
        actionCalloutStyle: KeyboardStyle.ActionCallout = .standard,
        inputCalloutStyle: KeyboardStyle.InputCallout = .standard
    ) -> some View {
        self
            .keyboardActionCalloutContainer(
                calloutContext: calloutContext.actionContext,
                keyboardContext: keyboardContext,
                style: actionCalloutStyle
            )
            .keyboardInputCalloutContainer(
                calloutContext: calloutContext.inputContext,
                keyboardContext: keyboardContext,
                style: inputCalloutStyle
            )
    }

    /**
     Apply a keyboard action callout to the view.

     - Parameters:
       - calloutContext: The callout context to use.
       - keyboardContext: The keyboard context to use.
       - style: The style to apply, by default ``KeyboardStyle/ActionCallout/standard``.
     */
    func keyboardActionCalloutContainer(
        calloutContext: ActionCallout.Context,
        keyboardContext: KeyboardContext,
        style: KeyboardStyle.ActionCallout = .standard
    ) -> some View {
        self.overlay(
            ActionCallout(
                calloutContext: calloutContext,
                keyboardContext: keyboardContext,
                style: style
            )
        ).coordinateSpace(name: ActionCallout.coordinateSpace)
    }

    /**
     Apply a keyboard callout shadow to the view.

     - Parameters:
       - style: The style apply, by default `.standard`.
     */
    func keyboardCalloutShadow(
        style: KeyboardStyle.Callout = .standard
    ) -> some View {
        self.shadow(color: style.borderColor, radius: 0.4)
            .shadow(color: style.shadowColor, radius: style.shadowRadius)
    }
    
    /**
     Apply a keyboard input callout to the view.
     
     - Parameters:
       - calloutContext: The callout context to use.
       - keyboardContext: The keyboard context to use.
       - style: The style to apply, by default ``KeyboardStyle/InputCallout/standard``.
     */
    func keyboardInputCalloutContainer(
        calloutContext: InputCallout.Context,
        keyboardContext: KeyboardContext,
        style: KeyboardStyle.InputCallout = .standard
    ) -> some View {
        self.overlay(
            InputCallout(
                calloutContext: calloutContext,
                keyboardContext: keyboardContext,
                style: style
            )
        ).coordinateSpace(name: InputCallout.coordinateSpace)
    }
}
