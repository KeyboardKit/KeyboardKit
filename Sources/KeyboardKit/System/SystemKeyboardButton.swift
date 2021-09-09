//
//  SystemKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics the buttons that are used in an iOS system
 keyboard. It wraps a `SystemKeyboardButtonContent` view and
 applies a standard button style and action gestures to it.
 */
public struct SystemKeyboardButton<Content: View>: View {
    
    /// Create a system keyboard button.
    ///
    /// - Parameters:
    ///   - action: The keyboard action to apply.
    ///   - actionHandler: The keyboard action handler to use.
    ///   - appearance: The keyboard appearance to use.
    ///   - text: An optional text to override the standard action content.
    ///   - image: An optional image to override the standard action content.
    ///   - contentConfig: A content configuration block that can be used to modify the button content before applying a style and gestures to it.
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        text: String? = nil,
        image: Image? = nil,
        contentConfig: @escaping ContentConfig) {
        self.action = action
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.text = text
        self.image = image
            self.contentConfig = contentConfig
    }
    
    private let action: KeyboardAction
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let image: Image?
    private let text: String?
    private let contentConfig: ContentConfig
    
    public typealias ContentConfig = (SystemKeyboardButtonContent) -> Content
    
    @State private var isPressed = false
    
    @EnvironmentObject private var context: KeyboardContext
    
    @ViewBuilder
    public var body: some View {
        buttonContent
            .keyboardButtonStyle(
                for: action,
                appearance: appearance,
                isPressed: isPressed)
            .keyboardGestures(
                for: action,
                context: context,
                isPressed: $isPressed,
                actionHandler: actionHandler)
    }
}

public extension SystemKeyboardButton where Content == SystemKeyboardButtonContent {
    
    /// Create a system keyboard button that does not modify
    /// the content before applying a style and gestures.
    ///
    /// - Parameters:
    ///   - action: The keyboard action to apply.
    ///   - actionHandler: The keyboard action handler to use.
    ///   - appearance: The keyboard appearance to use.
    ///   - text: An optional text to override the standard action content.
    ///   - image: An optional image to override the standard action content.
    ///   - contentConfig: A content configuration block, to adjust the content before presenting it.
    init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        text: String? = nil,
        image: Image? = nil) {
        self.init(
            action: action,
            actionHandler: actionHandler,
            appearance: appearance,
            text: text,
            image: image,
            contentConfig: { $0 })
    }
}

private extension SystemKeyboardButton {
    
    var buttonContent: some View {
        contentConfig(
            SystemKeyboardButtonContent(
                action: action,
                text: text,
                image: image)
        )
    }
}

struct SystemKeyboardButton_Previews: PreviewProvider {
    
    static func button(for action: KeyboardAction) -> some View {
        SystemKeyboardButton(
            action: action,
            actionHandler: PreviewKeyboardActionHandler(),
            appearance: PreviewKeyboardAppearance()) {
                $0.padding()
            }
    }
    
    static func customButton(for action: KeyboardAction) -> some View {
        SystemKeyboardButton(
            action: action,
            actionHandler: PreviewKeyboardActionHandler(),
            appearance: PreviewKeyboardAppearance()) {
                $0.padding()
            }
    }
    
    static var previews: some View {
        VStack {
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
