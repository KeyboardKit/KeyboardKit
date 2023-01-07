//
//  SystemKeyboardActionButtonContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view renders content for a system keyboard button that
 is based on a certain ``KeyboardAction``.

 This view will adapt its content to conform to the provided
 `action` and `appearance` and applies keyboard gestures for
 the provided `action`, `actionHandler` and `context`.

 The view sets up gestures, line limits, vertical offset etc.
 and aims to make the button mimic an iOS system keyboard as
 closely as possible.
 */
public struct SystemKeyboardActionButtonContent: View {
    
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
        if action == .nextKeyboard {
            #if os(iOS) || os(tvOS)
            NextKeyboardButton()
            #else
            Image.keyboardGlobe
            #endif
        } else if action == .space {
            spaceView
        } else if let image = appearance.buttonImage(for: action) {
            image.scaleEffect(appearance.buttonImageScaleFactor(for: action))
        } else if let text = appearance.buttonText(for: action) {
            textView(for: text)
        } else {
            Text("")
        }
    }
}

private extension SystemKeyboardActionButtonContent {
    
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
        )
        .padding(3)
        .minimumScaleFactor(0.5)
    }
}

private extension SystemKeyboardActionButtonContent {
    
    var localeName: String {
        keyboardContext.locale.localizedLanguageName ?? ""
    }
    
    var shouldShowLocaleName: Bool {
        keyboardContext.locales.count > 1
    }
    
    var spaceText: String {
        appearance.buttonText(for: action) ?? ""
    }
}

#if os(iOS) || os(tvOS)
struct SystemKeyboardButtonContent_Previews: PreviewProvider {
    
    static let multiLocaleContext: KeyboardContext = {
        var context = KeyboardContext(controller: .shared)
        context.locales = [
            KeyboardLocale.english.locale,
            KeyboardLocale.swedish.locale]
        return context
    }()
    
    static func preview(
        for action: KeyboardAction,
        multiLocale: Bool = false) -> some View {
        SystemKeyboardActionButtonContent(
            action: action,
            appearance: .preview,
            keyboardContext: multiLocale ? multiLocaleContext : .preview)
    }
    
    static var previews: some View {
        HStack {
            preview(for: .backspace)
            preview(for: .space, multiLocale: false)
            preview(for: .space, multiLocale: true)
            preview(for: .character("PascalCased"))
            preview(for: .character("lowercased"))
        }
    }
}
#endif
