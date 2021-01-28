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
    
    public init(_ text: String) {
        self.replacement = text
        self.title = text
        self.subtitle = nil
        self.additionalInfo = [:]
    }
    
    public init(
        replacement: String,
        title: String,
        subtitle: String? = nil,
        additionalInfo: [String: Any] = [:]) {
        self.replacement = replacement
        self.title = title
        self.subtitle = subtitle
        self.additionalInfo = additionalInfo
    }
    
    public let replacement: String
    public let title: String
    public let subtitle: String?
    public let additionalInfo: [String: Any]
}
