//
//  AutocompleteContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any class that can hold
 a collection of autocomplete suggestions.
 */
public protocol AutocompleteContext: AnyObject {
    
    var suggestions: [AutocompleteSuggestion] { get set }
}
