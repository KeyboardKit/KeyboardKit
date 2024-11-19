//
//  Autocomplete+NextWordPredictionRequest.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This type can be used by ``Autocomplete/LocalService``
    /// to perform next word prediction.
    ///
    /// You can register a next word prediction request with
    /// the ``Autocomplete/LocalService/nextWordPredictionRequest``
    /// property. This is automatically done when you set up
    /// your keyboard with a ``KeyboardApp`` in which you've
    /// defined a ``KeyboardApp/AutocompleteConfiguration-swift.struct/nextWordPredictionRequest``.
    ///
    /// KeyboardKit Pro unlocks a couple of pre-defined next
    /// word prediction requests, like these:
    ///
    /// - ``claude(apiKey:apiUrl:anthropicVersion:model:maxTokens:systemPrompt:)``
    /// - ``openAI(apiKey:apiUrl:apiKeyHeader:apiKeyValuePrefix:model:maxTokens:systemPrompt:)``
    ///
    /// You have to provide your own private API keys to use
    /// the Claude and OpenAI-based requests, since you must
    /// pay for your own consumption. You can customize both
    /// request types to great extent.
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
