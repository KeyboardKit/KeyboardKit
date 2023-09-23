//
//  KeyboardPreviews+Layout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-08-26.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {

    static var preview: KeyboardLayout {
        KeyboardPreviews.PreviewKeyboardLayoutProvider()
            .keyboardLayout(for: .preview)
    }
}

public extension KeyboardLayoutProvider where Self == KeyboardPreviews.PreviewKeyboardLayoutProvider {

    static var preview: KeyboardLayoutProvider {
        KeyboardPreviews.PreviewKeyboardLayoutProvider()
    }
}

public extension KeyboardPreviews {
 
    class PreviewKeyboardLayoutProvider: KeyboardLayoutProvider {

        public init(keyboardContext: KeyboardContext = .preview) {
            provider = StandardKeyboardLayoutProvider()
        }

        private let provider: KeyboardLayoutProvider

        public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
            provider.keyboardLayout(for: context)
        }
    }
}
