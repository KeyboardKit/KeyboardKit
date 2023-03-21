//
//  AutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to give autocomplete suggestions as the user types.

 Simply call ``autocompleteSuggestions(for:completion:)`` to
 get autocomplete suggestions based on the provided text.

 KeyboardKit doesn't have a standard provider as it does for
 other services. It sets up a ``DisabledAutocompleteProvider``
 that serves as a placeholder until a real one is registered.

 KeyboardKit Pro unlocks two autocomplete providers when you
 register a valid license. `StandardAutocompleteProvider` is
 a locale-specific and non-predictive provider that runs all
 operations locally, while the `ExternalAutocompleteProvider`
 can be used to communicate with any external api or service.

 KeyboardKit Pro registers a standard provider instance when
 you register a pro license.
 */
public protocol AutocompleteProvider: AnyObject {

    /**
     The currently applied locale.
     */
    var locale: Locale { get set }


    /**
     Get autocomplete suggestions for the provided `text`.
     */
    func autocompleteSuggestions(
        for text: String,
        completion: @escaping AutocompleteCompletion
    )


    /**
     Whether or not the provider can ignore words.
     */
    var canIgnoreWords: Bool { get }

    /**
     Whether or not the provider can lean words.
     */
    var canLearnWords: Bool { get }

    /**
     The provider's currently ignored words.
     */
    var ignoredWords: [String] { get }

    /**
     The provider's currently learned words.
     */
    var learnedWords: [String] { get }


    /**
     Whether or not the provider has ignored a certain word.
     */
    func hasIgnoredWord(_ word: String) -> Bool

    /**
     Whether or not the provider has learned a certain word.
     */
    func hasLearnedWord(_ word: String) -> Bool

    /**
     Make the provider ignore a certain word.
     */
    func ignoreWord(_ word: String)

    /**
     Make the provider learn a certain word.
     */
    func learnWord(_ word: String)

    /**
     Remove a certain ignored word from the provider.
     */
    func removeIgnoredWord(_ word: String)

    /**
     Make the provider unlearn a certain word.
     */
    func unlearnWord(_ word: String)
}

public typealias AutocompleteCompletion = (AutocompleteResult) -> Void

public typealias AutocompleteResult = Result<[AutocompleteSuggestion], Error>
