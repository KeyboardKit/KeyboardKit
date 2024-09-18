//
//  Autocomplete+Shorthands.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension AutocompleteService where Self == Autocomplete.DisabledService {

    /// Create a disabled autocomplete service.
    ///
    /// - Parameters:
    ///   - suggestions: The suggestions to present.
    static var disabled: Self {
        Autocomplete.DisabledService()
    }

    /// Create a disabled autocomplete service.
    ///
    /// - Parameters:
    ///   - suggestions: The suggestions to present.
    static func disabled(
        suggestions: [Autocomplete.Suggestion] = []
    ) -> Self {
        Autocomplete.DisabledService(suggestions: suggestions)
    }
}
