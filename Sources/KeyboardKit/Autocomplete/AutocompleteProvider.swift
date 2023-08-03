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

 KeyboardKit Pro will unlock two providers when you register
 a license. ``LocalAutocompleteProvider`` is locale-specific
 and runs on device, while ``RemoteAutocompleteProvider`` is
 a base class that can be configured to communicate with any
 remote APIs or web services.

 KeyboardKit Pro registers a standard provider instance when
 you register a pro license.
 
 > v8.0: This protocol will be made async in KeyboardKit 8.0.
 */
public protocol AutocompleteProvider: AnyObject {

    /**
     The currently applied locale.
     */
    var locale: Locale { get set }


    /**
     Get autocomplete suggestions for the provided `text`.
     
     > v8.0: This will be made async in KeyboardKit 8.0.
     */
    func autocompleteSuggestions(
        for text: String,
        completion: @escaping Completion
    )

    
    /// > v8.0: This will be removed in KeyboardKit 8.0.
    typealias Completion = (CompletionResult) -> Void

    /// > v8.0: This will be removed in KeyboardKit 8.0.
    typealias CompletionResult = Result<[AutocompleteSuggestion], Error>


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
