//
//  KeyboardStyle+Shorthands.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardStyleService where Self == KeyboardStyle.StandardService {

    /// Create a standard callout service.
    ///
    /// - Parameters:
    ///   - keyboardContext: The keyboard context to use.
    static func standard(
        keyboardContext: KeyboardContext
    ) -> Self {
        KeyboardStyle.StandardService(
            keyboardContext: keyboardContext
        )
    }
}
