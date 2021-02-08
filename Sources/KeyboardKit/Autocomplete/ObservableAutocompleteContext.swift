//
//  ObservableAutocompleteContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Combine

/**
 This is an observable `AutocompleteContext` implementation.
 */
public class ObservableAutocompleteContext: ObservableObject, AutocompleteContext {
    
    public init() {}
    
    @Published public var suggestions: [AutocompleteSuggestion] = []
}
