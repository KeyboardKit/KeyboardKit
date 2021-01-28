//
//  SystemKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view resolves the correct content for a certain action,
 given a custom text and image, which overrides the standard
 behaviors for the provided action.
 */
public struct SystemKeyboardButtonContent: View {
    
    public init(
        action: KeyboardAction,
        text: String? = nil,
        image: Image? = nil) {
        self.action = action
        self.text = text
        self.image = image
    }
    
    private let action: KeyboardAction
    private let image: Image?
    private let text: String?
    private var appearance: KeyboardAppearanceProvider { context.keyboardAppearanceProvider }
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    @ViewBuilder
    public var body: some View {
        if action == .nextKeyboard {
            AnyView(NextKeyboardButton())
        } else if let image = buttonImage {
            AnyView(image)
        } else if let text = buttonText {
            AnyView(textView(for: text))
        } else {
            AnyView(Text(""))
        }
    }
}

private extension SystemKeyboardButtonContent {
    
    var buttonImage: Image? {
        image ?? action.standardButtonImage(for: context)
    }
    
    var buttonText: String? {
        text ?? appearance.text(for: action)
    }
    
    func textView(for text: String) -> some View {
        Text(text)
            //.minimumScaleFactor(0.1)
            .lineLimit(1)
            .offset(y: text.isLowercased ? -2 : 0)
    }
}

private extension String {
    
    var isLowercased: Bool { self == lowercased() }
    var isUppercased: Bool { self != lowercased() }
}
