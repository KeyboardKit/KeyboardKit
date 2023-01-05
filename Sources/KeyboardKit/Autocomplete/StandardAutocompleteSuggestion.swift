//
//  StandardAutocompleteSuggestions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct is a standard suggestion that can be used by an
 autocomplete suggestion provider.
 */
public struct StandardAutocompleteSuggestion: AutocompleteSuggestion {
    
    /**
     Create a suggestion with completely custom properties.

     - Parameters:
       - text: The text to apply when the suggestion is used.
       - title: The suggestion display title, by default `title`.
       - isAutocomplete: Whether or not the suggestion is an autocompleting suggestion, by default `false`.
       - isUnknown: Whether or not the suggestion is an unknown suggestion, by default `false`.
       - subtitle: The suggestion subtitle, by default `nil`.
       - additionalInfo: Any additional information, by default `empty`.
     */
    public init(
        text: String,
        title: String? = nil,
        isAutocomplete: Bool = false,
        isUnknown: Bool = false,
        subtitle: String? = nil,
        additionalInfo: [String: Any] = [:]
    ) {
        self.text = text
        self.title = title ?? text
        self.isAutocomplete = isAutocomplete
        self.isUnknown = isUnknown
        self.subtitle = subtitle
        self.additionalInfo = additionalInfo
    }
    
    /**
     The text that should be sent to the text document proxy
     and replace the current word.
     */
    public var text: String
    
    /**
     The text that should be presented to the user.
     */
    public var title: String
    
    /**
     Whether or not this suggestion is an autocompete result.
     */
    public var isAutocomplete: Bool
    
    /**
     Whether or not this suggestion is unknown to the system.
     */
    public var isUnknown: Bool
    
    /**
     An optional subtitle that can complete the `title`.
     */
    public var subtitle: String?
    
    /**
     An optional dictionary that can contain additional info.
     */
    public var additionalInfo: [String: Any]
}
