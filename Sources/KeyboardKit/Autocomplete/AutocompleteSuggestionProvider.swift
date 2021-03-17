//
//  AutocompleteSuggestionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to get autocomplete suggestions for a certain text.
 
 You can implement the protocol in any way you like, e.g. to
 use a built-in database or by connecting to an external api.
 Note that network operations require full access and can be
 slow for your users.
 
 The KeyboardKit Pro `StandardAutocompleteSuggestionProvider`
 implementation can be unlocked with a pro license.
 */
public protocol AutocompleteSuggestionProvider {
    
    /**
     Get autocomplete suggestions for a certain text.
     */
    func autocompleteSuggestions(for text: String, completion: AutocompleteResponse)
    
    
    /**
     Whether or not the provider can lean words.
     */
    var canIgnoreWords: Bool { get }
    
    /**
     The provider's currently ignored words.
     */
    var ignoredWords: [String] { get set }
    
    /**
     Whether or not the provider has ignored a certain word.
     */
    func hasIgnoredWord(_ word: String) -> Bool
    
    /**
     Make the provider ignore a certain word.
     */
    func ignoreWord(_ word: String)
    
    /**
     Remove a certain ignored word from the provider.
     */
    func removeIgnoredWord(_ word: String)
    
    
    /**
     Whether or not the provider can lean words.
     */
    var canLearnWords: Bool { get }
    
    /**
     Whether or not the provider has learned a certain word.
     */
    func hasLearnedWord(_ word: String) -> Bool
    
    /**
     Make the provider learn a certain word.
     */
    func learnWord(_ word: String)
    
    /**
     Make the provider unlearn a certain word.
     */
    func unlearnWord(_ word: String)
}

public typealias AutocompleteResponse = (AutocompleteResult) -> Void
public typealias AutocompleteResult = Result<[AutocompleteSuggestion], Error>
