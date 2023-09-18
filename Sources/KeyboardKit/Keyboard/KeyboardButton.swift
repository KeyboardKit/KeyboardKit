//
//  KeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics a native keyboard button.

 This view adapts its content to the provided action, states
 and services. You can use a `contentConfig` to customize or
 replace the content view.
 
 You can turn any view into a keyboard button like this view,
 by using the `.keyboardButton(...)` view modifier.
 */
public struct KeyboardButton<Content: View>: View {

    /**
     Create a keyboard button view.

     - Parameters:
       - action: The keyboard action to apply.
       - actionHandler: The action handler to use.
       - styleProvider: The style provider to use.
       - keyboardContext: The keyboard context to which the button should apply.
       - calloutContext: The callout context to affect, if any.
       - contentConfig: A configuration block that can be used to customize or replace the standard button content.
     */
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        styleProvider: KeyboardStyleProvider,
        keyboardContext: KeyboardContext,
        calloutContext: CalloutContext?,
        contentConfig: @escaping ContentConfig
    ) {
        self.action = action
        self.actionHandler = actionHandler
        self.styleProvider = styleProvider
        self.keyboardContext = keyboardContext
        self.calloutContext = calloutContext
        self.contentConfig = contentConfig
    }

    /**
     Create a keyboard button view.

     - Parameters:
       - action: The keyboard action to apply.
       - actionHandler: The action handler to use.
       - styleProvider: The style provider to use.
       - keyboardContext: The keyboard context to which the button should apply.
       - calloutContext: The callout context to affect, if any.
     */
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        styleProvider: KeyboardStyleProvider,
        keyboardContext: KeyboardContext,
        calloutContext: CalloutContext?
    ) where Content == KeyboardButtonContent {
        self.init(
            action: action,
            actionHandler: actionHandler,
            styleProvider: styleProvider,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            contentConfig: { $0 }
        )
    }
    
    private let action: KeyboardAction
    private let actionHandler: KeyboardActionHandler
    private let styleProvider: KeyboardStyleProvider
    private let keyboardContext: KeyboardContext
    private let calloutContext: CalloutContext?
    private let contentConfig: ContentConfig

    @State
    private var isPressed = false
    
    public typealias ContentConfig = (_ standardContent: KeyboardButtonContent) -> Content
        
    public var body: some View {
        buttonContent
            .keyboardButton(
                for: action,
                style: style,
                actionHandler: actionHandler,
                calloutContext: calloutContext,
                isPressed: $isPressed
            )
    }
}

private extension KeyboardButton {
    
    var buttonContent: some View {
        contentConfig(
            KeyboardButtonContent(
                action: action,
                styleProvider: styleProvider,
                keyboardContext: keyboardContext
            )
        )
    }
    
    var style: KeyboardStyle.Button {
        styleProvider.buttonStyle(
            for: action,
            isPressed: isPressed
        )
    }
}

struct KeyboardButton_Previews: PreviewProvider {
    
    static func button(for action: KeyboardAction) -> some View {
        KeyboardButton(
            action: action,
            actionHandler: .preview,
            styleProvider: .preview,
            keyboardContext: .preview,
            calloutContext: .preview
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
