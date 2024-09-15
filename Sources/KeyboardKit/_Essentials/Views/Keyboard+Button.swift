//
//  Keyboard+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This view mimics a native keyboard button.
    ///
    /// The view adapts its content to fit the action, state
    /// and services that are passed in.
    ///
    /// You can use an optional `contentConfig` view builder
    /// to customize or replace the button content view.
    ///
    /// You can turn any view into a button, by applying the
    /// `.keyboardButton(...)` view modifier.
    struct Button<Content: View>: View {
        
        /// Create a keyboard button.
        ///
        /// - Parameters:
        ///   - action: The keyboard action to apply.
        ///   - actionHandler: The action handler to use.
        ///   - repeatGestureTimer: The repeat gesture timer to use, if any.
        ///   - styleService: The style service to use.
        ///   - keyboardContext: The keyboard context to which the button should apply.
        ///   - calloutContext: The callout context to affect, if any.
        ///   - edgeInsets: The edge insets to apply to the interactable area, if any.
        ///   - isPressed: An external boolean binding for the pressed state, if any.
        ///   - content: An optional content builder that can be used to customize or replace the standard button content.
        public init(
            action: KeyboardAction,
            actionHandler: KeyboardActionHandler,
            repeatGestureTimer: GestureButtonTimer? = nil,
            styleService: KeyboardStyleService,
            keyboardContext: KeyboardContext,
            calloutContext: CalloutContext?,
            edgeInsets: EdgeInsets = .init(),
            isPressed: Binding<Bool>? = nil,
            @ViewBuilder content: @escaping ContentBuilder
        ) {
            self.action = action
            self.actionHandler = actionHandler
            self.repeatGestureTimer = repeatGestureTimer
            self.styleService = styleService
            self.keyboardContext = keyboardContext
            self.calloutContext = calloutContext
            self.edgeInsets = edgeInsets
            self.isPressed = isPressed
            self.content = content
        }
        
        /// Create a keyboard button.
        ///
        /// - Parameters:
        ///   - action: The keyboard action to apply.
        ///   - actionHandler: The action handler to use.
        ///   - repeatGestureTimer: The repeat gesture timer to use, if any.
        ///   - styleService: The style service to use.
        ///   - keyboardContext: The keyboard context to which the button should apply.
        ///   - calloutContext: The callout context to affect, if any.
        ///   - edgeInsets: The edge insets to apply to the interactable area, if any.
        ///   - isPressed: An external boolean binding for the pressed state, if any.
        public init(
            action: KeyboardAction,
            actionHandler: KeyboardActionHandler,
            repeatGestureTimer: GestureButtonTimer? = nil,
            styleService: KeyboardStyleService,
            keyboardContext: KeyboardContext,
            calloutContext: CalloutContext?,
            edgeInsets: EdgeInsets = .init(),
            isPressed: Binding<Bool>? = nil
        ) where Content == Keyboard.ButtonContent {
            self.init(
                action: action,
                actionHandler: actionHandler,
                repeatGestureTimer: repeatGestureTimer,
                styleService: styleService,
                keyboardContext: keyboardContext,
                calloutContext: calloutContext,
                edgeInsets: edgeInsets,
                isPressed: isPressed,
                content: { $0 }
            )
        }
        
        private let action: KeyboardAction
        private let actionHandler: KeyboardActionHandler
        private let repeatGestureTimer: GestureButtonTimer?
        private let styleService: KeyboardStyleService
        private let keyboardContext: KeyboardContext
        private let calloutContext: CalloutContext?
        private let edgeInsets: EdgeInsets
        private var isPressed: Binding<Bool>?
        private let content: ContentBuilder
        
        @SwiftUI.State
        private var isPressedInternal = false
        
        public typealias ContentBuilder = (_ content: Keyboard.ButtonContent) -> Content
        
        public var body: some View {
            buttonContent
                .keyboardButton(
                    for: action,
                    style: style,
                    actionHandler: actionHandler,
                    repeatGestureTimer: repeatGestureTimer,
                    keyboardContext: keyboardContext,
                    calloutContext: calloutContext,
                    edgeInsets: edgeInsets,
                    isPressed: isPressed ?? $isPressedInternal
                )
        }


        // MARK: - Deprecated

        @available(*, deprecated, message: "Use the styleService initializer instead.")
        public init(
            action: KeyboardAction,
            actionHandler: KeyboardActionHandler,
            repeatGestureTimer: GestureButtonTimer? = nil,
            styleProvider: KeyboardStyleService,
            keyboardContext: KeyboardContext,
            calloutContext: CalloutContext?,
            edgeInsets: EdgeInsets = .init(),
            isPressed: Binding<Bool>? = nil,
            @ViewBuilder content: @escaping ContentBuilder
        ) {
            self.action = action
            self.actionHandler = actionHandler
            self.repeatGestureTimer = repeatGestureTimer
            self.styleService = styleProvider
            self.keyboardContext = keyboardContext
            self.calloutContext = calloutContext
            self.edgeInsets = edgeInsets
            self.isPressed = isPressed
            self.content = content
        }

        @available(*, deprecated, message: "Use the styleService initializer instead.")
        public init(
            action: KeyboardAction,
            actionHandler: KeyboardActionHandler,
            repeatGestureTimer: GestureButtonTimer? = nil,
            styleProvider: KeyboardStyleService,
            keyboardContext: KeyboardContext,
            calloutContext: CalloutContext?,
            edgeInsets: EdgeInsets = .init(),
            isPressed: Binding<Bool>? = nil
        ) where Content == Keyboard.ButtonContent {
            self.init(
                action: action,
                actionHandler: actionHandler,
                styleService: styleProvider,
                keyboardContext: keyboardContext,
                calloutContext: calloutContext,
                edgeInsets: edgeInsets,
                isPressed: isPressed,
                content: { $0 }
            )
        }

    }
}

private extension Keyboard.Button {
    
    var buttonContent: some View {
        content(
            Keyboard.ButtonContent(
                action: action,
                styleService: styleService,
                keyboardContext: keyboardContext
            )
        )
    }
    
    var style: Keyboard.ButtonStyle {
        styleService.buttonStyle(
            for: action,
            isPressed: isPressed?.wrappedValue ?? isPressedInternal
        )
    }
}

#Preview {
    
    struct Preview: View {
        
        @State
        private var isPressed = false
        
        func button(for action: KeyboardAction) -> some View {
            Keyboard.Button(
                action: action,
                actionHandler: .preview,
                styleService: .preview,
                keyboardContext: .preview,
                calloutContext: .preview
            ) {
                $0.frame(width: 80, height: 80)
            }
        }
        
        var body: some View {
            
            VStack {
                button(for: .backspace)
                button(for: .space)
                button(for: .nextKeyboard)
                button(for: .character("a"))
                button(for: .character("A"))
                Keyboard.Button(
                    action: .emoji(.init("😀")),
                    actionHandler: .preview,
                    styleService: .preview,
                    keyboardContext: .preview,
                    calloutContext: .preview,
                    edgeInsets: .init(top: 10, leading: 20, bottom: 30, trailing: 0),
                    isPressed: $isPressed
                )
                .background(isPressed ? Color.white : Color.clear)
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(10)
            .environment(\.sizeCategory, .extraExtraLarge)
        }
    }
    
    return Preview()
}
