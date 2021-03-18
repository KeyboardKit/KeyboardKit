//
//  AutocompleteSuggestions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol describes result data that can be returned by
 an autocomplete suggestion provider. You can implement your
 own types or use `StandardAutocompleteSuggestion`.
 */
public protocol AutocompleteSuggestion {
    
    /**
     The text that should be sent to the text document proxy
     and replace the current word.
     
     The `text` can differ from the `title`, for instance if
     the title should be more expressive ("Did you mean <X>").
     */
    var text: String { get }
    
    
    /**
     Whether or not this suggestion should be applied when a
     user types a word delimiter.
     
     An autocompleting suggestion is typically surrounded by
     a white, rounded square when presented in an iOS system
     keyboard.
     */
    var isAutocomplete: Bool { get }
    
    /**
     Whether or not this suggestion is unknown to the system.
     
     Unknown suggestions can be returned e.g. when there are
     not enough real suggestions. An autocomplete suggestion
     provider can then for instance return a currently typed
     word as an "unknown" suggestion.
     
     An unknown suggestion is typically surrounded by quotes
     when presented in an iOS system keyboard.
     */
    var isUnknown: Bool { get }


    /**
     The text that should be presented to the user.
     
     The `text` can differ from the `title`, for instance if
     the title should be more expressive ("Did you mean <X>").
     */
    var title: String { get }
    
    /**
     An optional subtitle that can complete the `title`.
     */
    var subtitle: String? { get }
    
    /**
     An optional dictionary that can contain additional info.
     */
    var additionalInfo: [String: Any] { get }
}
