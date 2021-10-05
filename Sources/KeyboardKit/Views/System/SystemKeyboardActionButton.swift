//
//  SystemKeyboardActionButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics the buttons that are used in an iOS system
 keyboard. It wraps a `SystemKeyboardButton` view and uses a
 `SystemKeyboardActionButtonContent` to resolves its content.
 
 You can use the `contentConfig` to customize the content in
 the button to fit your needs.
 
 The view uses the provided `context` and `actionHandler` to
 perform actions when the button is tapped, which means that
 you can create this button anywhere and it will trigger the
 correct gesture actions for tap, long press, drag etc.
 
 `SystemKeyboardButton` can be used to create a basic button
 that just looks correct, but doesn't do anything.
 */
public struct SystemKeyboardActionButton<Content: View>: View {
    
    /**
     Create a system keyboard button.
     
     - Parameters:
       - action: The keyboard action to apply.
       - actionHandler: The keyboard action handler to use.
       - appearance: The keyboard appearance to use.
       - contentConfig: A content configuration block that can be used to modify the button content before applying a style and gestures to it.
     */
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        contentConfig: @escaping ContentConfig) {
        self.action = action
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.contentConfig = contentConfig
    }
    
    private let action: KeyboardAction
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let contentConfig: ContentConfig
    
    /**
     This typealias represents the configuration action that
     is used to customize the content of the button.
     */
    public typealias ContentConfig = (SystemKeyboardActionButtonContent) -> Content
    
    @State private var isPressed = false
    
    @EnvironmentObject private var context: KeyboardContext
    
    public var body: some View {
        button.keyboardGestures(
            for: action,
            context: context,
            actionHandler: actionHandler,
            isPressed: $isPressed)
    }
}

private extension SystemKeyboardActionButton {
    
    var button: some View {
        SystemKeyboardButton(
            content: buttonContent,
            style: buttonStyle)
    }
    
    var buttonStyle: SystemKeyboardButtonStyle {
        appearance.systemKeyboardButtonStyle(
            for: action,
            isPressed: isPressed)
    }
}

public extension SystemKeyboardActionButton where Content == SystemKeyboardActionButtonContent {
    
    /**
     Create a system keyboard button that does not modify
     the content before applying a style and gestures.
     
     - Parameters:
       - action: The keyboard action to apply.
       - actionHandler: The keyboard action handler to use.
       - appearance: The keyboard appearance to use.
       - contentConfig: A content configuration block, to adjust the content before presenting it.
     */
    init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance) {
        self.init(
            action: action,
            actionHandler: actionHandler,
            appearance: appearance,
            contentConfig: { $0 })
    }
}

private extension SystemKeyboardActionButton {
    
    var buttonContent: some View {
        contentConfig(
            SystemKeyboardActionButtonContent(
                action: action,
                appearance: appearance)
        )
    }
}

struct SystemKeyboardActionButton_Previews: PreviewProvider {
    
    static func button(for action: KeyboardAction) -> some View {
        SystemKeyboardActionButton(
            action: action,
            actionHandler: .preview,
            appearance: PreviewKeyboardAppearance()) {
                $0.frame(width: 60, height: 60)
            }
    }
    
    static var previews: some View {
        VStack {
            button(for: .backspace)
            button(for: .space)
            button(for: .character("a"))
            button(for: .character("A"))
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
        .keyboardPreview()
    }
}
