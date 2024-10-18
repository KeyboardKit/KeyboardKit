//
//  Dictation+Shorthands.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension DictationService where Self == Dictation.DisabledService {

    /// Create a disabled dictation service.
    static var disabled: Self {
        Dictation.DisabledService(context: .preview)
    }
}

public extension DictationService where Self == Dictation.DisabledService {

    /// Create a disabled dictation service.
    static func disabled(
        context: DictationContext
    ) -> Self {
        Dictation.DisabledService(
            context: context
        )
    }
}
