//
//  AutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to give autocomplete suggestions as the user types.
 
 The key function when using an autocomplete provider is the
 ``autocompleteSuggestions(for:completion:)``, which returns
 suggestions based on the provided text.
 
 KeyboardKit doesn't have an autocomplete provider as it has
 for most other services, just an internal disabled one that
 it uses as a placeholder until you inject your own provider
 or use KeyboardKit Pro.
 
 KeyboardKit Pro unlocks two autocomplete providers when you
 register a valid license. The `StandardAutocompleteProvider`
 is locale-specific and non-predictive, and is injected when
 you register a license. `ExternalAutocompleteProvider` is a
 base class that can be inherited to communicate with an api.
 
 If you don't have a Pro license, you can implement a custom
 autocomplete provider in any way you like. When you're done,
 just replace the controller service with the implementation
 to make the library use it instead.
 */
public protocol AutocompleteProvider: AnyObject {
    
    /**
     The currently applied locale.
     */
    var locale: Locale { get set }
    
    
    /**
     Get autocomplete suggestions for the provided `text`.
     */
    func autocompleteSuggestions(for text: String, completion: @escaping AutocompleteCompletion)
    
    
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
