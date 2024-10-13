//
//  KeyboardAction+Shorthands.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardActionHandler where Self == KeyboardAction.StandardHandler {

    /// Create a standard keyboard action handler.
    ///
    /// - Parameters:
    ///   - controller: The keyboard controller to use.
    static func standard(
        for controller: KeyboardController
    ) -> Self {
        KeyboardAction.StandardHandler(
            controller: controller
        )
    }

    /// Create a standard keyboard action handler.
    ///
    /// The `controller` parameter is optional, to allow you
    /// to set up later.
    ///
    /// - Parameters:
    ///   - controller: The keyboard controller to use, if any.
    ///   - keyboardContext: A custom keyboard context.
    ///   - keyboardBehavior: A custom keyboard behavior.
    ///   - autocompleteContext: A custom autocomplete context.
    ///   - autocompleteService: A custom autocomplete service.
    ///   - feedbackContext: A custom feedback context.
    ///   - feedbackService: A custom feedback service.
    ///   - spaceDragGestureHandler: A custom space gesture handler.
    static func standard(
        for controller: KeyboardController?,
        keyboardContext: KeyboardContext,
        keyboardBehavior: KeyboardBehavior,
        autocompleteContext: AutocompleteContext,
        autocompleteService: AutocompleteService,
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
