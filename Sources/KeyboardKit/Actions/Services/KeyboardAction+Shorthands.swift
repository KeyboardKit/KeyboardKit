//
//  KeyboardAction+Shorthands.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardActionHandler where Self == KeyboardAction.StandardHandler {

    #if os(iOS)
    /// Create a standard keyboard action handler.
    ///
    /// - Parameters:
    ///   - controller: The keyboard input controller to use.
    static func standard(
        controller: KeyboardInputViewController
    ) -> Self {
        KeyboardAction.StandardHandler(
            controller: controller
        )
    }
    #endif

    /// Create a standard keyboard action handler.
    ///
    /// - Parameters:
    ///   - controller: The keyboard controller to use, if any.
    ///   - keyboardContext: The keyboard context to use.
    ///   - keyboardBehavior: The keyboard behavior to use.
    ///   - autocompleteContext: The autocomplete context to use.
    ///   - autocompleteService: The autocomplete service to use.
    ///   - feedbackContext: The feedback context to use.
    ///   - feedbackService: The feedback service to use.
    ///   - spaceDragGestureHandler: The space gesture handler to use.
    static func standard(
        controller: KeyboardController?,
        keyboardContext: KeyboardContext,
        keyboardBehavior: KeyboardBehavior,
        autocompleteContext: AutocompleteContext,
        autocompleteService: AutocompleteService? = nil,
        feedbackContext: FeedbackContext,
        feedbackService: FeedbackService,
        spaceDragGestureHandler: Gestures.SpaceDragGestureHandler
    ) -> Self {
        KeyboardAction.StandardHandler(
            controller: controller,
            keyboardContext: keyboardContext,
            keyboardBehavior: keyboardBehavior,
            autocompleteContext: autocompleteContext,
            autocompleteService: autocompleteService,
            feedbackContext: feedbackContext,
            feedbackService: feedbackService,
            spaceDragGestureHandler: spaceDragGestureHandler
        )
    }
}
