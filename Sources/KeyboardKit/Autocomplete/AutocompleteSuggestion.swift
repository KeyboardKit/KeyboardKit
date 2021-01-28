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
    
    var replacement: String { get }
    var title: String { get }
    var subtitle: String? { get }
    var additionalInfo: [String: Any] { get }
}
