//
//  SystemKeyboardSpaceButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics a system space button, with custom content,
 that takes up as much horizontal space as needed.
 
 This view will adapt its content to conform to the provided
 `appearance` and applies keyboard gestures for the provided
 `actionHandler` and `context`.
 
 To mimic a native space button, that starts with displaying
 a locale text, then fades to the localized name for "space",
 use `SystemKeyboardSpaceButtonContent` as content.
 */
public struct SystemKeyboardSpaceButton<Content: View>: View {
    
    /**
     Create a system keyboard space button.
     
     - Parameters:
       - actionHandler: The name of the current locale, if any.
       - appearance: The keyboard appearance to use.
       - context: The keyboard context to which the button should apply.
       - content: The content to display inside the button.
     */
    public init(
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        @ViewBuilder content: @escaping ContentBuilder) {
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.context = context
        self.content = content()
    }
    
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let context: KeyboardContext
    private let content: Content
    
    private var action: KeyboardAction { .space }
    
    @State private var isPressed = false
        
    /**
     This typealias represents the configuration action that
     is used to customize the content of the button.
     */
    public typealias ContentBuilder = () -> Content
    
    public var body: some View {
        button
            .keyboardGestures(
                for: action,
                context: context,
                actionHandler: actionHandler,
                isPressed: $isPressed)
    }
}

private extension SystemKeyboardSpaceButton {
    
    var button: some View {
        SystemKeyboardButton(
            content: content.frame(maxWidth: .infinity),
            style: buttonStyle)
    }
    
    var buttonStyle: SystemKeyboardButtonStyle {
        appearance.systemKeyboardButtonStyle(
            for: action,
            isPressed: isPressed)
    }
}

struct SystemKeyboardSpaceButton_Previews: PreviewProvider {
    
    static var spaceText: some View {
        SystemKeyboardSpaceButtonContent(
            localeText: KeyboardLocale.english.localizedName,
            spaceText: KKL10n.space.text(for: .english))
    }
    
    static var spaceView: some View {
        SystemKeyboardSpaceButtonContent(
            localeText: KeyboardLocale.spanish.localizedName,
            spaceView: Text("🇪🇸"))
    }
    
    static func button<Content: View>(for content: Content) -> some View {
        SystemKeyboardSpaceButton(
            actionHandler: PreviewKeyboardActionHandler(),
            appearance: .crazy,
            context: .preview) {
                content.frame(height: 50)
            }
    }
    
    static var previews: some View {
        VStack {
            Group {
                button(for: spaceText)
                button(for: spaceView)
                button(for: Image.keyboardGlobe)
            }
            .padding()
            .background(Color.red)
            .cornerRadius(10)
        }.keyboardPreview()
    }
}
