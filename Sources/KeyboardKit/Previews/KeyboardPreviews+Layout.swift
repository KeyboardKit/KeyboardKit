//
//  Layout+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-08-26.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {

    /// This layout can be used in SwiftUI previews.
    static var preview: KeyboardLayout {
        KeyboardPreviews.LayoutProvider()
            .keyboardLayout(for: .preview)
    }
}

public extension KeyboardLayoutProvider where Self == KeyboardPreviews.LayoutProvider {

    /// This provider can be used in SwiftUI previews.
    static var preview: KeyboardLayoutProvider { KeyboardPreviews.LayoutProvider() }
}

public extension KeyboardPreviews {
 
    /// This provider can be used in SwiftUI previews.
    class LayoutProvider: KeyboardLayoutProvider {

        public init(keyboardContext: KeyboardContext = .preview) {
            provider = StandardKeyboardLayoutProvider()
        }

        private let provider: KeyboardLayoutProvider

        public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
            provider.keyboardLayout(for: context)
        }
    }
}
