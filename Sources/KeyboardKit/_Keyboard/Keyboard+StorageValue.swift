//
//  Keyboard+StorageValue.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2023-04-24.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//
//  Inspiration: https://nilcoalescing.com/blog/SaveCustomCodableTypesInAppStorageOrSceneStorage/
//

import Foundation
import SwiftUI

/// This type can wrap any `Codable` type to make it able to
/// store the value in `AppStorage` and `SceneStorage`.
///
/// This type uses `JSONEncoder` and `JSONDecoder` to encode
/// the value to data then decode it back to the source type.
///
/// > Important: JSON encoding may cause important type data
/// to disappear. For instance, JSON encoding a `Color` will
/// not include any information about alternate color values
/// for light and dark mode, high constrasts, etc.
public extension Keyboard {

    struct StorageValue<Value: Codable>: RawRepresentable {

        public var value: Value
    }
}

public extension Keyboard.StorageValue {

    init(_ value: Value) {
        self.value = value
    }

    init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode(Value.self, from: data)
        else { return nil }
        self = .init(result)
    }

    var rawValue: String {
        guard
            let data = try? JSONEncoder().encode(value),
            let result = String(data: data, encoding: .utf8)
        else { return "" }
        return result
    }
}
