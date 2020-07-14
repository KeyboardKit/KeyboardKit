//
//  AutocompleteSuggestionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 autocomplete suggestions based on a certain text.
 
 You can implement the protocol in any way you like, e.g. to
 use a built-in database or by connecting to an external api.
 
 Note that network operations require full access and can be
 slow for your users.
 */
public protocol AutocompleteSuggestionProvider {
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteResponse)
}

public typealias AutocompleteResponse = (AutocompleteResult) -> Void
public typealias AutocompleteResult = Result<[String], Error>
