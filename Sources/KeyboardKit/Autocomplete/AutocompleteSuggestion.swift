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
 
 Regarding terminology, autocorrect suggestions are rendered
 with a white background in a native keyboard, while unknown
 suggestions are wrapped in locale-specific quotation marks.
 */
public struct AutocompleteSuggestion {
    
    /**
     Create a suggestion with completely custom properties.

     - Parameters:
       - text: The text that should be sent to the proxy.
       - title: The text that should be presented to the user, by default `text`.
       - isAutocorrect: Whether or not this is an autocorrect suggestion, by default `false`.
       - isUnknown: Whether or not this is an unknown suggestion, by default `false`.
       - subtitle: An optional subtitle that can complete the `title`, by default `nil`.
       - additionalInfo: An optional dictionary that can contain additional info, by default `empty`.
     */
    public init(
        text: String,
        title: String? = nil,
        isAutocorrect: Bool = false,
        isUnknown: Bool = false,
        subtitle: String? = nil,
        additionalInfo: [String: Any] = [:]
    ) {
        self.text = text
        self.title = title ?? text
        self.isAutocorrect = isAutocorrect
        self.isUnknown = isUnknown
        self.subtitle = subtitle
        self.additionalInfo = additionalInfo
    }
    
    /// The text that should be sent to the proxy.
    public var text: String
    
    /// The text that should be presented to the user.
    public var title: String
    
    /// Whether or not this is an autocorrect suggestion.
    public var isAutocorrect: Bool
    
    /// Whether or not this is an unknown suggestion.
    public var isUnknown: Bool
    
    /// An optional subtitle that can complete the `title`.
    public var subtitle: String?
    
    /// An optional dictionary with additional info.
    public var additionalInfo: [String: Any]
}
