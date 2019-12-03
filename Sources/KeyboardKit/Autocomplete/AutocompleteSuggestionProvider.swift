//
//  AutocompleteSuggestionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation

public typealias AutocompleteResponse = (Result<[String], Error>) -> Void

/**
 This protocol can be implemented by classes that do provide
 autocomplete suggestions based on a certain text.
 
 You can implement the protocol in any way you like, e.g. to
 use a built-in database or by connecting to an external api.
 Note that network operations are very slow and also require
 you to request full access from your users.
 
 When using an autocomplete suggestion provider, you can ask
 it for suggestions at any time. However, a good practice is
 to only ask when the text in a document proxy changes, e.g.
 when the user types. Make sure to ignore duplicate requests
 for the same text, since suggestions may be fetched from an
 external api, using web requests.
 */
public protocol AutocompleteSuggestionProvider {
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteResponse)

    @available(*, deprecated, renamed: "autocompleteSuggestions(for:completion:)")
    func provideAutocompleteSuggestions(for text: String, completion: AutocompleteResponse)
}
