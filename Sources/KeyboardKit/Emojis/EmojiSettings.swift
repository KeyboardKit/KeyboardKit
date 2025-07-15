//
//  EmojiSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-07-15.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This type provides emoji-related settings.
///
/// All properties for this type are automatically stored in
/// ``KeyboardSettings/store`` with an `emojis` prefix.
public struct EmojiSettings {

    /// Create a custom settings instance.
    public init() {}

    /// The settings key prefix to use.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "emojis")
    }
    
    /// This value is used to keep track of used skin tones.
    @AppStorage("\(settingsPrefix)skinToneHistory", store: .keyboardSettings)
    var skintoneHistory = [Emoji: Emoji]()
}
