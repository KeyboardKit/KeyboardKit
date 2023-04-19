//
//  Layout+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-08-26.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {

    /**
     This preview layout can be used in SwiftUI previews.
     */
    static var preview: KeyboardLayout {
        PreviewKeyboardLayoutProvider().keyboardLayout(for: .preview)
    }
}

public extension KeyboardLayoutProvider where Self == PreviewKeyboardLayoutProvider {

    /**
     This preview provider can be used in SwiftUI previews.
     */
    static var preview: KeyboardLayoutProvider { PreviewKeyboardLayoutProvider() }
}


/**
 This layout provider can be used in SwiftUI previews.
 */
public class PreviewKeyboardLayoutProvider: KeyboardLayoutProvider {

    public init(keyboardContext: KeyboardContext = .preview) {
        let inputProvider = StandardInputSetProvider(keyboardContext: keyboardContext)
        provider = StandardKeyboardLayoutProvider(
            keyboardContext: .preview,
            inputSetProvider: inputProvider)
    }

    private let provider: KeyboardLayoutProvider

    public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        provider.keyboardLayout(for: context)
    }

    public func register(inputSetProvider: InputSetProvider) {
        provider.register(inputSetProvider: inputSetProvider)
    }
}
