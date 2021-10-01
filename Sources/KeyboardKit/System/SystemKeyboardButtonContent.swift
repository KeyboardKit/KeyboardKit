//
//  SystemKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view resolves the correct content for a certain action.
 
 If provided, the optional text and image is used instead of
 the standard action content.
 */
public struct SystemKeyboardButtonContent: View {
    
    public init(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        text: String? = nil,
        image: Image? = nil) {
        self.appearance = appearance
        self.style = appearance.systemKeyboardButtonStyle(for: action, isPressed: false)
        self.action = action
        self.text = text
        self.image = image
    }
    
    private let appearance: KeyboardAppearance
    private let style: SystemKeyboardButtonStyle
    private let action: KeyboardAction
    private let image: Image?
    private let text: String?
    
    @EnvironmentObject private var context: KeyboardContext
    
    @ViewBuilder
    public var body: some View {
        if action == .nextKeyboard {
            if #available(iOS 14.0, *) {
                NextKeyboardButton(tintColor: style.foregroundColor)
            } else {
                NextKeyboardButton()
            }
        } else if let image = buttonImage {
            image.flipped(for: context)
        } else if let text = buttonText {
            textView(for: text)
        } else {
            Text("")
        }
    }
}

private extension SystemKeyboardButtonContent {
    
    var buttonImage: Image? {
        image ?? action.standardButtonImage(for: context)
    }
    
    var buttonText: String? {
        text ?? appearance.buttonText(for: action)
    }
    
    func textView(for text: String) -> some View {
        Text(text)
            .lineLimit(1)
            .offset(y: action.isInputAction && text.isLowercased ? -2 : 0)
    }
}

private extension Image {
    
    @ViewBuilder
    func flipped(for context: KeyboardContext) -> some View {
        if context.isRtl {
            self.rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
        } else {
            self
        }
    }
}

private extension KeyboardContext {
    
    var isRtl: Bool {
        let direction = Locale.characterDirection(forLanguage: locale.languageCode ?? "")
        return direction == .rightToLeft
    }
}

struct SystemKeyboardButtonContent_Previews: PreviewProvider {
    
    static var previews: some View {
        SystemKeyboardButtonContent(
            action: .backspace,
            appearance: .preview)
            .keyboardPreview()
    }
}
