//
//  SystemKeyboardButtonContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view generates the content of a system keyboard button
 that should trigger a certain ``KeyboardAction``.

 This view will adapt its content to conform to the provided
 `action` and `appearance`. It sets up gestures, line limits,
 vertical offset etc. and aims to mimic an iOS system button
 as closely as possible.
 */
public struct SystemKeyboardButtonContent: View {
    
    /**
     Create a system keyboard action button content view.
     
     - Parameters:
       - action: The keyboard action to use.
       - appearance: The appearance to apply to the content.
       - keyboardContext: The keyboard context to use.
     */
    public init(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        keyboardContext: KeyboardContext
    ) {
        self.action = action
        self.appearance = appearance
        self.keyboardContext = keyboardContext
    }
    
    private let action: KeyboardAction
    private let appearance: KeyboardAppearance
    private let keyboardContext: KeyboardContext
    
    public var body: some View {
        bodyContent
            .padding(3)
            .contentShape(Rectangle())
    }
}

private extension SystemKeyboardButtonContent {

    @ViewBuilder
    var bodyContent: some View {
        #if os(iOS) || os(tvOS)
        if action == .nextKeyboard {
            NextKeyboardButton { bodyView }
        } else {
            bodyView
        }
        #else
        bodyView
        #endif
    }

    @ViewBuilder
    var bodyView: some View {
        if action == .space {
            spaceView
        } else if let image = appearance.buttonImage(for: action) {
            image.scaleEffect(appearance.buttonImageScaleFactor(for: action))
        } else if let text = appearance.buttonText(for: action) {
            textView(for: text)
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
    
    func textView(for text: String) -> some View {
        SystemKeyboardButtonText(
            text: text,
            action: action
        ).minimumScaleFactor(0.5)
    }
}

private extension SystemKeyboardButtonContent {
    
    var localeName: String {
        keyboardContext.locale.localizedLanguageName
    }
    
    var shouldShowLocaleName: Bool {
        keyboardContext.locales.count > 1
    }
    
    var spaceText: String {
        appearance.buttonText(for: action) ?? ""
    }
}

struct SystemKeyboardButtonContent_Previews: PreviewProvider {
    
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
        SystemKeyboardButtonContent(
            action: action,
            appearance: .preview,
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
