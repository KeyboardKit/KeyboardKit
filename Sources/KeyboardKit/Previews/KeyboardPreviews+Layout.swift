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
        KeyboardPreviews.LayoutService()
            .keyboardLayout(for: .preview)
    }
}

public extension KeyboardLayoutService where Self == KeyboardPreviews.LayoutService {

    static var preview: KeyboardLayoutService {
        KeyboardPreviews.LayoutService()
    }
}

public extension KeyboardPreviews {
 
    class LayoutService: KeyboardLayoutService {

        public init(keyboardContext: KeyboardContext = .preview) {
            service = KeyboardLayout.StandardLayoutService()
        }

        private let service: KeyboardLayoutService

        public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
            service.keyboardLayout(for: context)
        }
    }
}
