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
public protocol AutocompleteSuggestion {
    
    var replacement: String { get }
    var title: String { get }
    var subtitle: String? { get }
    var additionalInfo: [String: Any] { get }
}
