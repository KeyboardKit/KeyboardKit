//
//  KeyboardButtonContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view generates the content of a system keyboard button
 that should trigger the provided ``KeyboardAction``.

 This view will adapt its content to conform to the provided
 `action`, `actionHandler` and `keyboardContext`.

 The view sets up gestures, line limits, vertical offset etc.
 and styles the button according to the `styleProvider`. You
 can use the `contentConfig` to further customize it.
 */
public struct KeyboardButtonContent: View {
    
    /**
     Create a system keyboard action button content view.
     
     - Parameters:
       - action: The keyboard action to use.
       - styleProvider: The style provider to use.
       - keyboardContext: The keyboard context to use.
     */
    public init(
        action: KeyboardAction,
        styleProvider: KeyboardStyleProvider,
        keyboardContext: KeyboardContext
    ) {
        self.action = action
        self.styleProvider = styleProvider
        self.keyboardContext = keyboardContext
    }
    
    private let action: KeyboardAction
    private let styleProvider: KeyboardStyleProvider
    private let keyboardContext: KeyboardContext
    
    public var body: some View {
        bodyContent
            .padding(3)
            .contentShape(Rectangle())
    }
}

private extension KeyboardButtonContent {

    @ViewBuilder
    var bodyContent: some View {
        if action == .space {
            spaceView
        } else if let image = styleProvider.buttonImage(for: action) {
            image.scaleEffect(styleProvider.buttonImageScaleFactor(for: action))
        } else if let text = styleProvider.buttonText(for: action) {
            textView(for: action, text: text)
        } else {
            Text("")
        }
    }
    
    var spaceView: some View {
        SystemKeyboardSpaceContent(
            localeText: shouldShowLocaleName ? localeName : spaceText,
            spaceText: spaceText
        )
    }
    
    func textView(for action: KeyboardAction, text: String) -> some View {
        SystemKeyboardButtonText(
            text: text,
            action: action
        )
        .minimumScaleFactor(0.5)
        .padding(.bottom, styleProvider.buttonContentBottomMargin(for: action))
    }
}

private extension KeyboardButtonContent {
    
    var localeName: String {
        keyboardContext.locale.localizedLanguageName
    }
    
    var shouldShowLocaleName: Bool {
        keyboardContext.locales.count > 1
    }
    
    var spaceText: String {
        styleProvider.buttonText(for: action) ?? ""
    }
}

struct KeyboardButtonContent_Previews: PreviewProvider {
    
    static let multiLocaleContext: KeyboardContext = {
        var context = KeyboardContext.preview
        context.locales = [
            KeyboardLocale.english.locale,
            KeyboardLocale.swedish.locale]
        return context
    }()
    
    static func preview(
        for action: KeyboardAction,
        multiLocale: Bool = false
    ) -> some View {
        KeyboardButtonContent(
            action: action,
            styleProvider: .preview,
            keyboardContext: multiLocale ? multiLocaleContext : .preview
        ).background(Color.gray)
    }
    
    static var previews: some View {
        VStack {
            preview(for: .backspace)
            preview(for: .nextKeyboard)
            preview(for: .nextLocale)
            preview(for: .keyboardType(.emojis))
            preview(for: .space, multiLocale: false)
            preview(for: .space, multiLocale: true)
            preview(for: .character("PascalCased"))
            preview(for: .character("lowercased"))
        }
    }
}
