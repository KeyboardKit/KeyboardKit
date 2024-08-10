//
//  AutocompleteService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// used perform autocomplete as the user types.
///
/// Simply call ``autocompleteSuggestions(for:)`` to perform
/// autocomplete and return suggestions for a provided text.
///
/// Words can be learned using ``learnWord(_:)`` and ignored
/// with ``ignoreWord(_:)``. Although it's up to the service,
/// learned words should be persisted and ignored words only
/// apply to the current service instance.
///
/// Not every service supports ignoring/learning words. Make
/// sure to check the ``canLearnWords`` and ``canIgnoreWords``
/// properties before exposing any such features to the user.
///
/// Once you have a list of suggestions, you can use them to
/// perform ``nextCharacterPredictions(forText:suggestions:)``
/// to predict which characters the user will type next.
///
/// KeyboardKit doesn't have a standard autocomplete service
/// as it has for other services. Instead, a disabled one is
/// used until you setup KeyboardKit Pro or a custom service.
///
/// See <doc:Autocomplete-Article> for more information.
public protocol AutocompleteService: AnyObject {

    /// The currently applied locale.
    var locale: Locale { get set }


    /// Get autocomplete suggestions for the provided `text`.
    func autocompleteSuggestions(
        for text: String
    ) async throws -> [Autocomplete.Suggestion]

    /// Get next character predictions for the provided text
    /// and a list of suggestions.
    func nextCharacterPredictions(
        forText text: String,
        suggestions: [Autocomplete.Suggestion]
    ) async throws -> [Character: Double]


    /// Whether the service can ignore words.
    var canIgnoreWords: Bool { get }

    /// Whether the service can lean words.
    var canLearnWords: Bool { get }

    /// The service's currently ignored words.
    var ignoredWords: [String] { get }

    /// The service's currently learned words.
    var learnedWords: [String] { get }


    /// Whether the service has ignored a certain word.
    func hasIgnoredWord(_ word: String) -> Bool

    /// Whether the service has learned a certain word.
    func hasLearnedWord(_ word: String) -> Bool

    /// Make the service ignore a certain word.
    func ignoreWord(_ word: String)

    /// Make the service learn a certain word.
    func learnWord(_ word: String)

    /// Remove a certain ignored word from the service.
    func removeIgnoredWord(_ word: String)

    /// Make the service unlearn a certain word.
    func unlearnWord(_ word: String)
}

public extension AutocompleteService {

    /// Make the service ignore a certain suggestion.
    func ignore(_ suggestion: Autocomplete.Suggestion) {
        ignoreWord(suggestion.text)
    }

    /// Make the service ignore a collection of words.
    func ignoreWords(_ words: [String]) {
        words.forEach(ignoreWord)
    }

    /// Make the service learn a certain suggestion.
    func learn(_ suggestion: Autocomplete.Suggestion) {
        learnWord(suggestion.text)
    }

    /// Remove a certain ignored suggested from the service.
    func removeIgnoredSuggestion(_ suggestion: Autocomplete.Suggestion) {
        removeIgnoredWord(suggestion.text)
    }

    /// Make the service unlearn a certain suggestion.
    func unlearn(_ suggestion: Autocomplete.Suggestion) {
        unlearnWord(suggestion.text)
    }
}
