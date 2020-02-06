//
//  AutocompleteSuggestionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation

public typealias AutocompleteResponse = (AutocompleteResult) -> Void
public typealias AutocompleteResult = Result<[String], Error>

/**
 This protocol can be implemented by classes that can return
 autocomplete suggestions based on a certain input text.
 
 You can implement the protocol in any way you like, e.g. to
 use a built-in database or by connecting to an external api.
 Note that network operations request full access and can be
 slow for users.
 */
public protocol AutocompleteSuggestionProvider {
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteResponse)

    @available(*, deprecated, renamed: "autocompleteSuggestions(for:completion:)")
    func provideAutocompleteSuggestions(for text: String, completion: AutocompleteResponse)
}
