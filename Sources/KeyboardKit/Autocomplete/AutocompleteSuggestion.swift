//
//  AutocompleteSuggestion.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct is a standard suggestion that can be used by an
 autocomplete suggestion provider.
 */
public struct AutocompleteSuggestion {
    
    /**
     Create a suggestion with completely custom properties.

     - Parameters:
       - text: The text that should be sent to the text document proxy.
       - title: The text that should be presented to the user, by default `text`.
       - isAutocomplete: Whether or not this is an autocompleting suggestion, by default `false`.
       - isUnknown: Whether or not this is an unknown suggestion, by default `false`.
       - subtitle: An optional subtitle that can complete the `title`, by default `nil`.
       - additionalInfo: An optional dictionary that can contain additional info, by default `empty`.
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
     The text that should be sent to the text document proxy.
     */
    public var text: String
    
    /**
     The text that should be presented to the user.
     */
    public var title: String
    
    /**
     Whether or not this is an autocompleting suggestion.

     These suggestions are typically shown in white, rounded
     squares when presented in an iOS system keyboard.
     */
    public var isAutocomplete: Bool
    
    /**
     Whether or not this is an unknown suggestion.

     These suggestions are typically surrounded by quotation
     marks when presented in an iOS system keyboard.
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
