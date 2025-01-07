//
//  Autocomplete+NextWordPredictionRequest.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-18.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This type can be used to enable next word prediction.
    ///
    /// You can easily enable next word prediction by adding
    /// a pre-defined request type to your ``KeyboardApp``'s
    /// ``KeyboardApp/autocomplete`` value. You can also add
    /// a request to ``Autocomplete/LocalAutocompleteService``
    /// at any time, e.g. to let your users set up their own
    /// service configuration and API key.
    ///
    /// KeyboardKit Pro unlocks some pre-configured requests:
    ///
    /// - ``claude(apiKey:apiUrl:anthropicVersion:model:maxTokens:systemPrompt:)``
    /// - ``openAI(apiKey:apiUrl:apiKeyHeader:apiKeyValuePrefix:model:maxTokens:systemPrompt:)``
    ///
    /// You have to provide your own private API keys to use
    /// these requests.
    struct NextWordPredictionRequest {

        enum RequestError: Error {
            case invalidUrl(String)
        }

        typealias Text = String

        /// The request type.
        public var type: NextWordPredictionRequestType

        var predictionRequest: (Text) throws -> URLRequest
        var predictionParser: (Data) throws -> [String]
    }
}

extension Autocomplete.NextWordPredictionRequest {

    static func urlRequest(for string: String) throws -> URLRequest {
        guard let url = URL(string: string) else {
            throw RequestError.invalidUrl(string)
        }
        return URLRequest(url: url)
    }
}
