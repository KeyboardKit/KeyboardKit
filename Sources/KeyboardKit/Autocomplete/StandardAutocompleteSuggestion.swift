//
//  StandardAutocompleteSuggestions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct is a standard result that can be returned by an
 autocomplete suggestion provider.
 */
public struct StandardAutocompleteSuggestion: AutocompleteSuggestion {
    
    public init(
        _ text: String,
        isAutocomplete: Bool = false,
        isUnknown: Bool = false) {
        self.text = text
        self.isAutocomplete = isAutocomplete
        self.isUnknown = isUnknown
        self.title = text
        self.subtitle = nil
        self.additionalInfo = [:]
    }
    
    public init(
        text: String,
        isAutocomplete: Bool = false,
        isUnknown: Bool = false,
        title: String? = nil,
        subtitle: String? = nil,
        additionalInfo: [String: Any] = [:]) {
        self.text = text
        self.isAutocomplete = isAutocomplete
        self.isUnknown = isUnknown
        self.title = title ?? text
        self.subtitle = subtitle
        self.additionalInfo = additionalInfo
    }
    
    public let text: String
    public let isAutocomplete: Bool
    public let isUnknown: Bool
    public let title: String
    public let subtitle: String?
    public let additionalInfo: [String: Any]
}
