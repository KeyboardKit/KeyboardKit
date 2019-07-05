//
//  AutocompleteSuggestionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol can be implemented by anyone that can provide
 autocomplete suggestions based on a certain text.
 
 When using the protocol in a keyboard extension, you should
 call `provideAutocompleteSuggestions(for:)` whenever a user
 changes the text in the text document proxy.
 
 You can use the proxy's `currentWord` extension to find out
 which word the user is (most probably) currently typing.
 
 */

import Foundation

public typealias AutocompleteResponse = (Result<[String], Error>) -> ()

public protocol AutocompleteSuggestionProvider {

    func provideAutocompleteSuggestions(for text: String, completion: AutocompleteResponse)
}
