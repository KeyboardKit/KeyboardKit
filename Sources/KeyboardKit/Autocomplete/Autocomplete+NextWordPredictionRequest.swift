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
    /// You can use any of the predefined request types, for
    /// instance ``claude(apiKey:apiVersion:apiUrl:model:maxTokens:system:)``.
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
