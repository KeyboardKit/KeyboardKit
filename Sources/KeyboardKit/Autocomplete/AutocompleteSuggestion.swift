//
//  AutocompleteSuggestions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by autocomplete suggestion
 providers. It can be anything, as long as it can answer the
 required properties.
 
 You can use `additionalInfo` to store any app-specific data
 that you may need.
 */
public struct AutocompleteSuggestion {
    
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
