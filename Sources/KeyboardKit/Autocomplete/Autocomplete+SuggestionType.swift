//
//  Autocomplete+SuggestionType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-17.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This enum defines every autocomplete suggestion type
    /// that can be returned by an ``AutocompleteService``.
    enum SuggestionType: String, CaseIterable, Equatable {

        /// These suggestions are only applied when the user
        /// taps them.
        ///
        /// Native keyboards display all regular suggestions
        /// as plain text, but you can customize this.
        case regular

        /// These suggestions are automatically applied when
        /// the user taps a word or sentence delimiter.
        ///
        /// Native keyboards display autocorrect suggestions
        /// with a rounded white background.
        case autocorrect

        /// These suggestions can be used when the currently
        /// typed word is unknown, to automatically learn it.
        ///
        /// Native keyboards display unknown suggestions and
        /// the current word although known, with quotes.
        case unknown
    }
}
