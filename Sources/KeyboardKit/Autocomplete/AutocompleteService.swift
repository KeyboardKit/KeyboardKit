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
/// Simply call ``autocomplete(_:)`` to perform autocomplete
/// for the provided `text`. Pass in as much text as you can,
/// to give the service as much context as possible.
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
/// KeyboardKit doesn't have a standard autocomplete service
/// as it has for other services. Instead, a disabled one is
/// used until you setup KeyboardKit Pro or a custom service.
///
/// See <doc:Autocomplete-Article> for more information.
public protocol AutocompleteService: AnyObject {

    /// The currently applied locale.
    var locale: Locale { get set }


    /// Get autocomplete suggestions for the provided `text`.
    func autocomplete(
        _ text: String
    ) async throws -> Autocomplete.ServiceResult


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

    /// Perform a background autocomplete operation and sync
    /// the result or error to the provided context.
    func autocomplete(
        _ text: String,
        updating context: AutocompleteContext
    ) {
        Task {
            do {
                let result = try await autocomplete(text)
                context.update(with: result)
            } catch {
                context.update(with: error)
            }
        }
    }

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
