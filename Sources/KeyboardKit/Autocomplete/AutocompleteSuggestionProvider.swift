//
//  AutocompleteSuggestionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation

public typealias AutocompleteResponse = (Result<[String], Error>) -> ()

/**
 
 This protocol can be implemented by anyone that can provide
 autocomplete suggestions based on a certain text.
 
 When using the protocol in a keyboard extension, you should
 call `provideAutocompleteSuggestions(for:)` whenever a user
 types and changes the text in the text document proxy. Make
 sure to ignore duplicate requests for the same text.
 
 You can implement the protocol in any way you like, e.g. to
 use a built-in database or by connecting to an external api.
 Note that network operations are very slow and also require
 you to request full access from your users.
 
 */
public protocol AutocompleteSuggestionProvider {

    func provideAutocompleteSuggestions(for text: String, completion: AutocompleteResponse)
}
