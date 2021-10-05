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
 
 Note that this view only mimics the look of a system button
 for the provided `action` and `appearance` and does not add
 any gestures or button actions to itself. When you do apply
 gestures, make sure to change `isPressed` accordingly. This
 is easiest to do by creating your own wrapper view.
 
 You can use the `contentConfig` to customize the content in
 the button to fit your needs.
 
 `SystemKeyboardButton` can be used to create a basic button
 that have a fixed content and style.
 */
public struct SystemKeyboardActionButton<Content: View>: View {
    
    /**
     Create a system keyboard button.
     
     - Parameters:
       - action: The keyboard action to apply.
       - appearance: The keyboard appearance to use.
       - isPressed: Whether or not the button is pressed.
       - contentConfig: A content configuration block that can be used to modify the button content before applying a style and gestures to it.
     */
    public init(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        isPressed: Binding<Bool>,
        contentConfig: @escaping ContentConfig) {
        self.action = action
        self.appearance = appearance
        self._isPressed = isPressed
        self.contentConfig = contentConfig
    }
    
    private let action: KeyboardAction
    private let appearance: KeyboardAppearance
    private let contentConfig: ContentConfig

    @Binding private var isPressed: Bool
    
    /**
     This typealias represents the configuration action that
     is used to customize the content of the button.
     */
    public typealias ContentConfig = (SystemKeyboardActionButtonContent) -> Content
        
    public var body: some View {
        SystemKeyboardButton(
            content: buttonContent,
            style: buttonStyle)
    }
}

public extension SystemKeyboardActionButton where Content == SystemKeyboardActionButtonContent {
    
    /**
     Create a system keyboard button that does not modify
     the content before applying a style and gestures.
     
     - Parameters:
       - action: The keyboard action to apply.
       - appearance: The keyboard appearance to use.
       - isPressed: Whether or not the button is pressed.
     */
    init(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        isPressed: Binding<Bool>) {
        self.init(
            action: action,
            appearance: appearance,
            isPressed: isPressed,
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
    
    var buttonStyle: SystemKeyboardButtonStyle {
        appearance.systemKeyboardButtonStyle(
            for: action,
            isPressed: isPressed)
    }
}

struct SystemKeyboardActionButton_Previews: PreviewProvider {
    
    private struct Preview: View {
        
        let action: KeyboardAction
        
        @State private var isPressed = false
        
        var body: some View {
            SystemKeyboardActionButton(
                action: action,
                appearance: .preview,
                isPressed: $isPressed) {
                $0.frame(width: 80, height: 80)
                }.onPressGesture {
                    isPressed = true
                } onReleased: {
                    isPressed = false
                }
        }
    }
    
    static var previews: some View {
        VStack {
            Preview(action: .backspace)
            Preview(action: .nextKeyboard)
            Preview(action: .character("a"))
            Preview(action: .character("A"))
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
        .keyboardPreview()
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
