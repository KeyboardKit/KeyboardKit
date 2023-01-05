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
 an autocomplete suggestion provider.
 
 You can implement your own autocomplete suggestion types or
 use the standard `StandardAutocompleteSuggestion`.
 */
public protocol AutocompleteSuggestion {
    
    /**
     The text that should be sent to the text document proxy
     and replace the current word.
     
     The `text` can differ from the `title`, for instance if
     the title should be more detailed ("Did you mean <X>").
     */
    var text: String { get }

    /**
     The text that should be presented to the user.
     
     The `text` can differ from the `title`, for instance if
     the title should be more detailed ("Did you mean <X>").
     */
    var title: String { get }
    
    /**
     Whether or not this suggestion is an autocompete result,
     which should be applied when a word delimiter is typed.
     
     These suggestions are typically shown in white, rounded
     squares when presented in an iOS system keyboard.
     */
    var isAutocomplete: Bool { get }
    
    /**
     Whether or not this suggestion is unknown to the system.
     
     These suggestions are typically surrounded by quotation
     marks when presented in an iOS system keyboard.
     */
    var isUnknown: Bool { get }
    
    /**
     An optional subtitle that can complete the `title`.
     */
    var subtitle: String? { get }
    
    /**
     An optional dictionary that can contain additional info.
     */
    var additionalInfo: [String: Any] { get }
}
