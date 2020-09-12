//
//  AutocompleteContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any class that can hold
 a collection of autocomplete suggestions.
 
 One way to connect an `AutocompleteSuggestionProvider` with
 your views is to create an `AutocompleteContext`, inject it
 into your provider and update its suggestions whenever your
 provider finishes an autocomplete lookup. You can then bind
 the context suggestions to your view.
 
 If you target iOS 11 and 12, you can unfortunately only use
 `StandardAutocompleteContext`, which has a completion block
 for when its suggestion changes.
 
 If you target later iOS versions, you should instead import
 `KeyboardKitSwiftUI` and use `ObservableAutocompleteContext`
 instead of the standard one. It's an `ObservableObject` and
 lets you bind its suggestions to your views.
 */
public protocol AutocompleteContext: AnyObject {
    
    var suggestions: AutocompleteSuggestions { get set }
}
