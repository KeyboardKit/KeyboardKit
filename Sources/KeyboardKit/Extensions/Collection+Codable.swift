//
//  Collection+Codable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This extension makes `Dictionary` able to store `Codable`
/// types, by serializing the collection to JSON.
///
/// > Important: JSON encoding may cause important type data
/// to disappear. For instance, JSON encoding a `Color` will
/// not include any information about alternate color values
/// for light and dark mode, high constrasts, etc.
extension Dictionary: @retroactive RawRepresentable where Key: Codable, Value: Codable {
    
    public init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode([Key: Value].self, from: data)
        else { return nil }
        self = result
    }

    public var rawValue: String {
        guard
            let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else { return "{}" }
        return result
    }
}

/// This extension makes `Array` able to store Codable types,
/// by serializing the collection to JSON.
///
/// > Important: JSON encoding may cause important type data
/// to disappear. For instance, JSON encoding a `Color` will
/// not include any information about alternate color values
/// for light and dark mode, high constrasts, etc.
extension Array: @retroactive RawRepresentable where Element: Codable {
    
    public init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        self = result
    }

    public var rawValue: String {
        guard
            let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else { return "[]" }
        return result
    }
}
