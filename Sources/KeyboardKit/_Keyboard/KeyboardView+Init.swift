//
//  KeyboardView+Init.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-11-07.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardView where ButtonContent == KeyboardView.StandardButtonContent,
                                        ButtonView == KeyboardView.StandardButtonView,
                                        CollapsedView == KeyboardView.StandardCollapsedView,
                                        EmojiKeyboard == KeyboardView.StandardEmojiKeyboard,
                                        Toolbar == KeyboardView.StandardToolbar {

    /// Create a keyboard based on state and services, using
    /// standard button and component views.
    ///
    /// - Parameters:
    ///   - layout: A custom keyboard layout, if any.
    ///   - state: The keyboard state to use.
    ///   - services: The keyboard services to use.
    ///   - renderBackground: Whether to render the style background.
    init(
        layout: KeyboardLayout? = nil,
        state: Keyboard.State,
        services: Keyboard.Services,
        renderBackground: Bool? = nil
    ) {
        self.init(
            layout: layout,
            state: state,
            services: services,
            renderBackground: renderBackground,
            buttonContent: { $0.view },
            buttonView: { $0.view },
            collapsedView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: { $0.view }
        )
    }

    /// Create a keyboard based on raw properties, using the
    /// standard button and component views.
    ///
    /// - Parameters:
    ///   - layout: The layout to use.
    ///   - actionHandler: The action handler to use.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - styleService: The style service to use.
    ///   - keyboardContext: The keyboard context to use.
    ///   - autocompleteContext: The autocomplete context to use.
    ///   - calloutContext: The callout context to use.
    ///   - renderBackground: Whether to render the style background.
    init(
        layout: KeyboardLayout,
        actionHandler: KeyboardActionHandler,
        repeatTimer: GestureButtonTimer? = nil,
        styleService: KeyboardStyleService,
        keyboardContext: KeyboardContext,
        autocompleteContext: AutocompleteContext,
        calloutContext: CalloutContext,
        renderBackground: Bool? = nil
    ) {
        self.init(
            layout: layout,
            actionHandler: actionHandler,
            repeatTimer: repeatTimer,
            styleService: styleService,
            keyboardContext: keyboardContext,
            autocompleteContext: autocompleteContext,
            calloutContext: calloutContext,
            renderBackground: renderBackground,
            buttonContent: { $0.view },
            buttonView: { $0.view },
            collapsedView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: { $0.view }
        )
    }
}

public extension KeyboardView where ButtonContent == KeyboardView.StandardButtonContent,
                                        ButtonView == KeyboardView.StandardButtonView,
                                        CollapsedView == KeyboardView.StandardCollapsedView,
                                        EmojiKeyboard == KeyboardView.StandardEmojiKeyboard,
                                        Toolbar == KeyboardView.StandardToolbar {

    /// Create a keyboard based on state and services, using
    /// standard component views.
    ///
    /// - Parameters:
    ///   - layout: A custom keyboard layout, if any.
    ///   - state: The keyboard state to use.
    ///   - services: The keyboard services to use.
    ///   - renderBackground: Whether to render the style background.
    ///   - buttonContent: The content view to use for buttons.
    ///   - buttonView: The button view to use for an buttons.
    init(
        layout: KeyboardLayout? = nil,
        state: Keyboard.State,
        services: Keyboard.Services,
        renderBackground: Bool? = nil,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder
    ) {
        self.init(
            layout: layout,
            state: state,
            services: services,
            renderBackground: renderBackground,
            buttonContent: buttonContent,
            buttonView: buttonView,
            collapsedView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: { $0.view }
        )
    }

    /// Create a keyboard based on raw properties, using the
    /// standard component views.
    ///
    /// - Parameters:
    ///   - layout: The layout to use.
    ///   - actionHandler: The action handler to use.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - styleService: The style service to use.
    ///   - keyboardContext: The keyboard context to use.
    ///   - autocompleteContext: The autocomplete context to use.
    ///   - calloutContext: The callout context to use.
    ///   - renderBackground: Whether to render the style background.
    ///   - buttonContent: The content view to use for buttons.
    ///   - buttonView: The button view to use for an buttons.
    init(
        layout: KeyboardLayout,
        actionHandler: KeyboardActionHandler,
        repeatTimer: GestureButtonTimer? = nil,
        styleService: KeyboardStyleService,
        keyboardContext: KeyboardContext,
        autocompleteContext: AutocompleteContext,
        calloutContext: CalloutContext,
        renderBackground: Bool? = nil,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder
    ) {
        self.init(
            layout: layout,
            actionHandler: actionHandler,
            repeatTimer: repeatTimer,
            styleService: styleService,
            keyboardContext: keyboardContext,
            autocompleteContext: autocompleteContext,
            calloutContext: calloutContext,
            renderBackground: renderBackground,
            buttonContent: buttonContent,
            buttonView: buttonView,
            collapsedView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: { $0.view }
        )
    }
}
