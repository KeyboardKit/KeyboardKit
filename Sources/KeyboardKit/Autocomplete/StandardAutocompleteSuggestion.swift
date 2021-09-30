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
    
    public init(
        _ text: String,
        isAutocomplete: Bool = false,
        isUnknown: Bool = false) {
        self.text = text
        self.title = text
        self.isAutocomplete = isAutocomplete
        self.isUnknown = isUnknown
        self.subtitle = nil
        self.additionalInfo = [:]
    }
    
    public init(
        text: String,
        title: String? = nil,
        isAutocomplete: Bool = false,
        isUnknown: Bool = false,
        subtitle: String? = nil,
        additionalInfo: [String: Any] = [:]) {
        self.text = text
        self.title = title ?? text
        self.isAutocomplete = isAutocomplete
        self.isUnknown = isUnknown
        self.subtitle = subtitle
        self.additionalInfo = additionalInfo
    }
    
    public let text: String
    public let title: String
    public let isAutocomplete: Bool
    public let isUnknown: Bool
    public let subtitle: String?
    public let additionalInfo: [String: Any]
}
