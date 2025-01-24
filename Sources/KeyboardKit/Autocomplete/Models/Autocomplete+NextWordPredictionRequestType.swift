//
//  Autocomplete+NextWordPredictionRequestType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-12-06.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This enum defines all available next word prediction
    /// request types, for use in e.g. pickers.
    enum NextWordPredictionRequestType: String, CaseIterable, Identifiable, KeyboardModel {

        /// Perform next word prediction with the Claude API.
        case claude

        /// Perform next word prediction with the OpenAI API.
        case openAI
    }
}

public extension Autocomplete.NextWordPredictionRequestType {

    /// The request type's unique ID.
    var id: String { rawValue }

    /// The request type's display name
    var displayName: String {
        switch self {
        case .claude: "Claude"
        case .openAI: "OpenAI"
        }
    }

    /// The request service provider's website URL.
    var url: URL? {
        URL(string: urlString)
    }

    /// The request service provider's website URL string.
    var urlString: String {
        switch self {
        case .claude: "https://www.anthropic.com/api"
        case .openAI: "https://openai.com/api/"
        }
    }
}
