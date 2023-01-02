//
//  SystemKeyboardActionButtonContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view resolves the correct content for a certain action,
 which will result in either a text or image, or nothing. It
 also sets up line limits, vertical offsets etc.
 
 This view will also setup a special spacebar that shows the
 locale name if the `context` has more than a one locale.
 */
public struct SystemKeyboardActionButtonContent: View {
    
    /**
     Create a system keyboard button content view.
     
     - Parameters:
       - action: The action for which to generate content.
       - appearance: The appearance to apply to the content.
       - context: The context to use when resolving content.
     */
    public init(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        context: KeyboardContext
    ) {
        self.action = action
        self.appearance = appearance
        self.context = context
    }
    
    private let action: KeyboardAction
    private let appearance: KeyboardAppearance
    private let context: KeyboardContext
    
    public var body: some View {
        if action == .nextKeyboard {
            #if os(iOS) || os(tvOS)
            NextKeyboardButton()
            #else
            Image.keyboardGlobe
            #endif
        } else if action == .space {
            spaceView
        } else if let image = buttonImage {
            image
        } else if let text = buttonText {
            textView(for: text)
        } else {
            Text("")
        }
    }
}

private extension SystemKeyboardActionButtonContent {
    
    var buttonImage: Image? {
        appearance.buttonImage(for: action)
    }
    
    var buttonText: String? {
        appearance.buttonText(for: action)
    }
    
    var spaceView: some View {
        SystemKeyboardSpaceButtonContent(
            localeText: localeText,
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
        context.locale.localizedLanguageName ?? ""
    }
    
    var localeText: String {
        shouldShowLocaleName ? localeName : spaceText
    }
    
    var shouldShowLocaleName: Bool {
        context.locales.count > 1
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
            context: multiLocale ? multiLocaleContext : .preview)
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
