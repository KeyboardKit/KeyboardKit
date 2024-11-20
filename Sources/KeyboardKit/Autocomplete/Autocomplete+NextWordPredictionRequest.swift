//
//  Autocomplete+NextWordPredictionRequest.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This type can be used to enable next word prediction.
    ///
    /// You can register a next word prediction request with
    /// your ``KeyboardApp`` value, by adding the request to
    /// its ``KeyboardApp/autocomplete`` property. This will
    /// make KeyboardKit Pro inject it into the autocomplete
    /// service when you set it up with a valid Gold license.
    ///
    /// KeyboardKit Pro unlocks some pre-configured requests:
    ///
    /// - ``claude(apiKey:apiUrl:anthropicVersion:model:maxTokens:systemPrompt:)``
    /// - ``openAI(apiKey:apiUrl:apiKeyHeader:apiKeyValuePrefix:model:maxTokens:systemPrompt:)``
    ///
    /// You have to provide your own private API keys to use
    /// these requests. Visit the developer portal for these
    /// services to sign up, see price information, etc.
    struct NextWordPredictionRequest {

        enum RequestError: Error {
            case invalidUrl(String)
        }

        typealias Text = String

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
