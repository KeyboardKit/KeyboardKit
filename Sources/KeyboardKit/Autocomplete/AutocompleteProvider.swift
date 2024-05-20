//
//  AutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any classes that can
/// return autocomplete suggestions as the user types.
///
/// Simply call ``autocompleteSuggestions(for:)`` to perform
/// an autocomplete operation that returns suggestions for a
/// text in the current ``locale``.
///
/// Words can be learned using ``learnWord(_:)`` and ignored
/// using ``ignoreWord(_:)``. Learned words are persisted in
/// the system, and will be considered as new words from the
/// point they are learned, while ignored words will just be
/// ignored by the autocomplete provider.
///
/// Not all autocomplete providers support ignoring/learning
/// words. Check ``canLearnWords`` and ``canIgnoreWords`` to
/// check whether or not a provider supports it. Also, while
/// a provider may support ignoring and learning, it may not
/// be able to provide ``ignoredWords`` and ``learnedWords``.
///
/// KeyboardKit does not have a standard provider, as it has
/// for other services. Instead, a disabled provider will be
/// used until you register a custom provider, or register a
/// valid KeyboardKit Pro license key.
///
/// See <doc:Autocomplete-Article> for more information.
public protocol AutocompleteProvider: AnyObject {
    
    /// The currently applied locale.
    var locale: Locale { get set }


    /// Get autocomplete suggestions for the provided `text`.
    func autocompleteSuggestions(
        for text: String
    ) async throws -> [Autocomplete.Suggestion]
    
    
    /// Whether or not the provider can ignore words.
    var canIgnoreWords: Bool { get }

    /// Whether or not the provider can lean words.
    var canLearnWords: Bool { get }

    /// The provider's currently ignored words.
    var ignoredWords: [String] { get }

    /// The provider's currently learned words.
    var learnedWords: [String] { get }


    /// Whether or not the provider has ignored a certain word.
    func hasIgnoredWord(_ word: String) -> Bool

    /// Whether or not the provider has learned a certain word.
    func hasLearnedWord(_ word: String) -> Bool

    /// Make the provider ignore a certain word.
    func ignoreWord(_ word: String)

    /// Make the provider learn a certain word.
    func learnWord(_ word: String)

    /// Remove a certain ignored word from the provider.
    func removeIgnoredWord(_ word: String)

    /// Make the provider unlearn a certain word.
    func unlearnWord(_ word: String)
}

public extension AutocompleteProvider {
    
    /// Make the provider ignore a certain suggestion.
    func ignore(_ suggestion: Autocomplete.Suggestion) {
        ignoreWord(suggestion.text)
    }
    
    /// Make the provider ignore a collection of words.
    func ignoreWords(_ words: [String]) {
        words.forEach(ignoreWord)
    }
    
    /// Make the provider learn a certain suggestion.
    func learn(_ suggestion: Autocomplete.Suggestion) {
        learnWord(suggestion.text)
    }
    
    /// Remove a certain ignored suggested from the provider.
    func removeIgnoredSuggestion(_ suggestion: Autocomplete.Suggestion) {
        removeIgnoredWord(suggestion.text)
    }
    
    /// Make the provider unlearn a certain suggestion.
    func unlearn(_ suggestion: Autocomplete.Suggestion) {
        unlearnWord(suggestion.text)
    }
}
