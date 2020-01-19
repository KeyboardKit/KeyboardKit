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
 This protocol can be implemented by classes that do provide
 autocomplete suggestions based on a certain text.
 
 You can implement the protocol in any way you like, e.g. to
 use a built-in database or by connecting to an external api.
 Note that network operations can be slow and require you to
 request full access from your users.
 
 When using an autocomplete suggestion provider, you can ask
 it for suggestions at any time. However, a good practice is
 to only ask when a document proxy's text changes, e.g. when
 the user types.
 */
public protocol AutocompleteSuggestionProvider {
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteResponse)

    @available(*, deprecated, renamed: "autocompleteSuggestions(for:completion:)")
    func provideAutocompleteSuggestions(for text: String, completion: AutocompleteResponse)
}
