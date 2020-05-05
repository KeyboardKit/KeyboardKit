//
//  AutocompleteSuggestionProvider+Deprecated.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

public extension AutocompleteSuggestionProvider {
    
    @available(*, deprecated, renamed: "autocompleteSuggestions(for:completion:)")
    func provideAutocompleteSuggestions(for text: String, completion: AutocompleteResponse) {
        autocompleteSuggestions(for: text, completion: completion)
    }
}
