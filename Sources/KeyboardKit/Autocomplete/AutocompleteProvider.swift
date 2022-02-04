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
 used to provide autocomplete suggestions for the typed text.
 
 The key function when using an autocomplete provider is the
 ``autocompleteSuggestions(for:completion:)``, which returns
 suggestions based on the provided text.
 
 You can implement the protocol in any way you like, e.g. to
 use native Swift technologies, your own local library or by
 calling an external api. Note that using network operations
 require full access and can be slow for your users. 
 
 Note that KeyboardKit doesn't have an autocomplete provider
 implementation as it does for most other protocols. It only
 has an internal, disabled one that it uses as a placeholder
 until you inject your own provider or use a KeyboardKit Pro
 license to unlock the standard provider that it provides.
 
 KeyboardKit Pro has two autocomplete providers that you get
 access to as soon as you register a pro license. By default,
 it will register a `StandardAutocompleteProvider`, which is
 a basic provider that provides locale-specific autocomplete
 without word prediction. KeyboardKit Pro also comes with an
 additional `ExternalAutocompleteProvider` provider that can
 be used to communicate with an external api or web service.
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
