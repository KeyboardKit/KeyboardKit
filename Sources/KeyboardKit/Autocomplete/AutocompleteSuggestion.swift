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
     This text is what should be sent to the text proxy.
     */
    var replacement: String { get }
    
    /**
     The behavior indicates how the suggestion should behave.
     */
    var behavior: AutocompleteSuggestionBehavior { get }
    
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
     This text is what should be presented to the user.
     */
    var title: String { get }
    
    /**
     This optional subtitle is also optional to use.
     */
    var subtitle: String? { get }
    
    /**
     This dictionary can store additional information.
     */
    var additionalInfo: [String: Any] { get }
}

public enum AutocompleteSuggestionBehavior {
    
    /**
     Suggestions with this behavior should be applied when a
     types a word delimiter or explicitly taps them.
     
     This corresponds to the white background suggestions in
     a native system keyboard.
     */
    case automatic
    
    /**
     Suggestions with this behavior should be applied when a
     user explicitly taps them.
     */
    case manual
}
