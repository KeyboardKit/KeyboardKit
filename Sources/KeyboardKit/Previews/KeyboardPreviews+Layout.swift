//
//  KeyboardPreviews+Layout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-08-26.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {

    static var preview: KeyboardLayout {
        KeyboardPreviews.PreviewKeyboardLayoutService()
            .keyboardLayout(for: .preview)
    }
}

public extension KeyboardLayoutService where Self == KeyboardPreviews.PreviewKeyboardLayoutService {

    static var preview: KeyboardLayoutService {
        KeyboardPreviews.PreviewKeyboardLayoutService()
    }
}

public extension KeyboardPreviews {
 
    class PreviewKeyboardLayoutService: KeyboardLayoutService {

        public init(keyboardContext: KeyboardContext = .preview) {
            service = KeyboardLayout.StandardService()
        }

        private let service: KeyboardLayoutService

        public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
            service.keyboardLayout(for: context)
        }
    }
}
