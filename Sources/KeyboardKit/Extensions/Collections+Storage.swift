//
//  Collections+Storage.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

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
