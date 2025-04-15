//
//  Keyboard+ButtonContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This view renders the content for a certain keyboard
    /// button, based on a provided action and style service.
    struct ButtonContent: View {
        
        /// Create a keyboard button content view.
        ///
        /// - Parameters:
        ///   - action: The keyboard action to use.
        ///   - styleService: The style service to use.
        ///   - keyboardContext: The keyboard context to use.
        public init(
            action: KeyboardAction,
            styleService: KeyboardStyleService,
            keyboardContext: KeyboardContext
        ) {
            self.action = action
            self.styleService = styleService
            self._keyboardContext = .init(wrappedValue: keyboardContext)
        }
        
        private let action: KeyboardAction
        private let styleService: KeyboardStyleService
        
        @ObservedObject
        private var keyboardContext: KeyboardContext
        
        public var body: some View {
            bodyContent
                .padding(styleService.buttonContentInsets(for: action))
                .contentShape(Rectangle())
        }
    }
}

private extension Keyboard.ButtonContent {

    @ViewBuilder
    var bodyContent: some View {
        if let image = styleService.buttonImage(for: action) {
            image.scaleEffect(styleService.buttonImageScaleFactor(for: action))
        } else if action == .space {
            spaceView
        } else if let text = styleService.buttonText(for: action) {
            textView(for: action, text: text)
        } else {
            Text("")
        }
    }
    
    var spaceImage: Image? {
        styleService.buttonImage(for: .space)
    }
    
    var spaceView: some View {
        let text = styleService.buttonText(for: action) ?? ""
        let showLocale = keyboardContext.hasMultipleEnabledLocales
        let localeName = keyboardContext.locale.localizedLanguageName ?? ""
        return Keyboard.SpaceContent(
            localeText: showLocale ? localeName : text,
            spaceText: text
        )
    }
    
    func textView(for action: KeyboardAction, text: String) -> some View {
        Keyboard.ButtonTitle(
            text: text,
            action: action
        )
    }
}

#Preview {
    
    let multiLocaleContext: KeyboardContext = {
        let context = KeyboardContext.preview
        context.locales = [.english, .swedish]
        return context
    }()
    
    func preview(
        for action: KeyboardAction,
        multiLocale: Bool = false
    ) -> some View {
        Keyboard.ButtonContent(
            action: action,
            styleService: .preview,
            keyboardContext: multiLocale ? multiLocaleContext : .preview
        )
        
    }
    
    return VStack {
        preview(for: .backspace)
        preview(for: .nextKeyboard)
        preview(for: .nextLocale)
        preview(for: .keyboardType(.emojis))
        preview(for: .space, multiLocale: false)
        preview(for: .space, multiLocale: true)
        preview(for: .character("PascalCased"))
        preview(for: .character("lowercased"))
    }
    .padding()
    .background(Color.keyboardBackground)
}
