//
//  SystemKeyboardActionButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS)
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

 Use the ``SystemKeyboardButton`` if you just want to render
 a view that looks like a system keyboard button, but has no
 functionality.
 */
public struct SystemKeyboardActionButton<Content: View>: View {

    /**
     Create a system keyboard button view.

     - Parameters:
       - action: The keyboard action to apply.
       - actionHandler: The action handler to use.
       - appearance: The appearance to apply to the button.
       - keyboardContext: The keyboard context to which the button should apply.
       - contentConfig: A configuration block that can be used to customize or replace the standard button content.
     */
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        keyboardContext: KeyboardContext,
        contentConfig: @escaping ContentConfig
    ) {
        self.action = action
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.context = keyboardContext
        self.contentConfig = contentConfig
    }

    /**
     Create a system keyboard button view.

     - Parameters:
       - action: The keyboard action to apply.
       - actionHandler: The action handler to use.
       - appearance: The appearance to apply to the button.
       - keyboardContext: The keyboard context to which the button should apply.
     */
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        keyboardContext: KeyboardContext
    ) where Content == SystemKeyboardActionButtonContent {
        self.action = action
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.context = keyboardContext
        self.contentConfig = { $0 }
    }
    
    private let action: KeyboardAction
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let context: KeyboardContext
    private let contentConfig: ContentConfig

    @State
    private var isPressed = false
    
    /**
     This typealias represents an action that can be used to
     customize (or replace) a standard button content view.
     */
    public typealias ContentConfig = (_ standardContent: SystemKeyboardActionButtonContent) -> Content
        
    public var body: some View {
        SystemKeyboardButton(
            content: buttonContent,
            style: buttonStyle
        ).keyboardGestures(
            for: action,
            actionHandler: actionHandler,
            isPressed: $isPressed)
    }
}

private extension SystemKeyboardActionButton {
    
    var buttonContent: some View {
        contentConfig(
            SystemKeyboardActionButtonContent(
                action: action,
                appearance: appearance,
                keyboardContext: context
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

struct SystemKeyboardActionButton_Previews: PreviewProvider {
    
    static func button(for action: KeyboardAction) -> some View {
        SystemKeyboardActionButton(
            action: action,
            actionHandler: .preview,
            appearance: .preview,
            keyboardContext: .preview) {
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

private extension View {
    
    func onPressGesture(
        onPressed: @escaping () -> Void,
        onReleased: @escaping () -> Void) -> some View {
        self.gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in onPressed() }
                .onEnded { _ in onReleased() }
        )
    }
}
#endif
