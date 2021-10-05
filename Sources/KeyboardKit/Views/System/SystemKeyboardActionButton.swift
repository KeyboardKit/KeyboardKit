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
 
 This view will adapt its content to conform to the provided
 `action` and `appearance` and applies keyboard gestures for
 the provided `action`, `actionHandler` and `context`.

 You can use the `contentConfig` to customize the content in
 the button to fit your needs.
 
 If you want to create a basic button, `SystemKeyboardButton`
 will create a view that looks like a system keyboard button,
 but that doesn't have any functionality.
 */
public struct SystemKeyboardActionButton<Content: View>: View {
    
    /**
     Create a system keyboard button.
     
     - Parameters:
       - action: The keyboard action to apply.
       - actionHandler: The action handler to use when triggering actions.
       - appearance: The keyboard appearance to use.
       - context: The keyboard context to which the button should apply.
       - contentConfig: A content configuration block that can be used to modify the button content before applying a style and gestures to it.
     */
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        contentConfig: @escaping ContentConfig) {
        self.action = action
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.context = context
        self.contentConfig = contentConfig
    }
    
    private let action: KeyboardAction
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let context: KeyboardContext
    private let contentConfig: ContentConfig

    @State private var isPressed: Bool = false
    
    /**
     This typealias represents the configuration action that
     is used to customize the content of the button.
     */
    public typealias ContentConfig = (SystemKeyboardActionButtonContent) -> Content
        
    public var body: some View {
        button
            .keyboardGestures(
                for: action,
                context: context,
                actionHandler: actionHandler,
                isPressed: $isPressed)
    }
}

public extension SystemKeyboardActionButton where Content == SystemKeyboardActionButtonContent {
    
    /**
     Create a system keyboard button that does not modify
     the content before applying a style and gestures.
     
     - Parameters:
       - action: The keyboard action to apply.
       - actionHandler: The action handler to use when triggering actions.
       - appearance: The keyboard appearance to use.
       - context: The keyboard context to which the button should apply.
     */
    init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        context: KeyboardContext) {
        self.init(
            action: action,
            actionHandler: actionHandler,
            appearance: appearance,
            context: context,
            contentConfig: { $0 })
    }
}

private extension SystemKeyboardActionButton {
    
    var button: some View {
        SystemKeyboardButton(
            content: buttonContent,
            style: buttonStyle)
    }
    
    var buttonContent: some View {
        contentConfig(
            SystemKeyboardActionButtonContent(
                action: action,
                appearance: appearance)
        )
    }
    
    var buttonStyle: SystemKeyboardButtonStyle {
        appearance.systemKeyboardButtonStyle(
            for: action,
            isPressed: isPressed)
    }
}

struct SystemKeyboardActionButton_Previews: PreviewProvider {
    
    static func button(for action: KeyboardAction) -> some View {
        SystemKeyboardActionButton(
            action: action,
            actionHandler: .preview,
            appearance: PreviewKeyboardAppearance(),
            context: .preview) {
                $0.frame(width: 80, height: 80)
            }
    }
    
    static var previews: some View {
        VStack {
            button(for: .backspace)
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
