//
//  KeyboardButton+Content.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardButton {
    
    /**
     This view renders the content of a keyboard button, for
     the provided ``KeyboardAction``.
     
     This view will adapt its content to the provided action,
     style provider and keyboard context.
     
     The view sets up gestures, line limits, vertical offset,
     and styles the view according to the `styleProvider`.
     */
    struct Content: View {
        
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
}

private extension KeyboardButton.Content {

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
        KeyboardButton.SpaceContent(
            localeText: shouldShowLocaleName ? localeName : spaceText,
            spaceText: spaceText
        )
    }
    
    func textView(for action: KeyboardAction, text: String) -> some View {
        KeyboardButton.Title(
            text: text,
            action: action
        )
        .minimumScaleFactor(0.5)
        .padding(.bottom, styleProvider.buttonContentBottomMargin(for: action))
    }
}

private extension KeyboardButton.Content {
    
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

struct KeyboardButton_Content_Previews: PreviewProvider {
    
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
        KeyboardButton.Content(
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
