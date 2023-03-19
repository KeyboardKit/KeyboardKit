//
//  SystemKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view renders a system keyboard button that is based on
 a certain ``KeyboardAction``.

 This view will adapt its content to conform to the provided
 `action` and `appearance` and applies keyboard gestures for
 the provided `action`, `actionHandler` and `context`.

 The view sets up gestures, line limits, vertical offset etc.
 and aims to make the button mimic an iOS system keyboard as
 closely as possible. You can however use the `contentConfig`
 parameter to customize or replace the content view.
 */
public struct SystemKeyboardButton<Content: View>: View {

    /**
     Create a system keyboard button view.

     - Parameters:
       - action: The keyboard action to apply.
       - actionHandler: The action handler to use.
       - keyboardContext: The keyboard context to which the button should apply.
       - calloutContext: The callout context to affect, if any.
       - appearance: The appearance to apply to the button.
       - contentConfig: A configuration block that can be used to customize or replace the standard button content.
     */
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        appearance: KeyboardAppearance,
        contentConfig: @escaping ContentConfig
    ) {
        self.action = action
        self.actionHandler = actionHandler
        self.keyboardContext = keyboardContext
        self.calloutContext = calloutContext
        self.appearance = appearance
        self.contentConfig = contentConfig
    }

    /**
     Create a system keyboard button view.

     - Parameters:
       - action: The keyboard action to apply.
       - actionHandler: The action handler to use.
       - keyboardContext: The keyboard context to which the button should apply.
       - calloutContext: The callout context to affect, if any.
       - appearance: The appearance to apply to the button.
     */
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        appearance: KeyboardAppearance
    ) where Content == SystemKeyboardButtonContent {
        self.init(
            action: action,
            actionHandler: actionHandler,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            appearance: appearance,
            contentConfig: { $0 }
        )
    }
    
    private let action: KeyboardAction
    private let actionHandler: KeyboardActionHandler
    private let keyboardContext: KeyboardContext
    private let calloutContext: KeyboardCalloutContext?
    private let appearance: KeyboardAppearance
    private let contentConfig: ContentConfig

    @State
    private var isPressed = false
    
    /**
     This typealias represents an action that can be used to
     customize (or replace) a standard button content view.
     */
    public typealias ContentConfig = (_ standardContent: SystemKeyboardButtonContent) -> Content
        
    public var body: some View {
        buttonContent
            .systemKeyboardButtonStyle(
                buttonStyle,
                isPressed: isPressed
            )
            .keyboardGestures(
                for: action,
                actionHandler: actionHandler,
                calloutContext: calloutContext,
                isPressed: $isPressed
            )
    }
}

private extension SystemKeyboardButton {
    
    var buttonContent: some View {
        contentConfig(
            SystemKeyboardButtonContent(
                action: action,
                appearance: appearance,
                keyboardContext: keyboardContext
            )
        )
    }
    
    var buttonStyle: KeyboardButtonStyle {
        appearance.buttonStyle(
            for: action,
            isPressed: isPressed
        )
    }
}

struct SystemKeyboardButton_Previews: PreviewProvider {
    
    static func button(for action: KeyboardAction) -> some View {
        SystemKeyboardButton(
            action: action,
            actionHandler: .preview,
            keyboardContext: .preview,
            calloutContext: .preview,
            appearance: .preview
        ) {
            $0.frame(width: 80, height: 80)
        }
    }
    
    static var previews: some View {
        VStack {
            button(for: .backspace)
            button(for: .space)
            button(for: .nextKeyboard)
            button(for: .character("a"))
            button(for: .character("A"))
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
    }
}
