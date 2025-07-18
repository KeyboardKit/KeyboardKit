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
public struct EmojiSettings: Sendable {

    /// Create a custom settings instance.
    public init() {}

    /// The settings key prefix to use.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "emojis")
    }
    
    /// This value is used to keep track of used skin tones.
    @AppStorage("\(settingsPrefix)preferredSkinTones", store: .keyboardSettings)
    public var preferredSkinTones = [Emoji: Emoji]()
}

public extension EmojiSettings {

    /// Get the preferred skin tone for a certain emoji.
    ///
    /// Note that ``registerPreferredSkinTone(for:)`` stores
    /// values, with ``Emoji/neutralSkinToneVariant`` as the
    /// dictionary key.
    func preferredSkinTone(for emoji: Emoji) -> Emoji {
        guard emoji.hasSkinToneVariants else { return emoji }
        return preferredSkinTones[emoji] ?? emoji
    }

    /// Register the preferred skin tone for a certain emoji.
    func registerPreferredSkinTone(for emoji: Emoji) {
        preferredSkinTones[emoji.dictionaryKey] = emoji
    }

    /// Register a preferred skin tone for all emojis.
    func registerPreferredSkinToneForAllEmojis(using emoji: Emoji) {
        guard emoji.hasSkinToneVariants else { return }
        let tones = emoji.skinToneVariants.map { $0.char }
        let index = tones.firstIndex(where: { $0 == emoji.char }) ?? 0
        let emojis = Emoji.all.filter { $0.hasSkinToneVariants }
        emojis.forEach { emoji in
            registerPreferredSkinTone(for: emoji.skinToneVariants[index])
        }
        preferredSkinTones[emoji.dictionaryKey] = nil
    }

    /// Rest the preferred skin tone for a certain emoji.
    func resetPreferredSkinTone(for emoji: Emoji) {
        preferredSkinTones[emoji.dictionaryKey] = nil
    }

    /// Rest the preferred skin tone for all emojis.
    func resetPreferredSkinToneForAllEmojis() {
        Emoji.all.forEach {
            resetPreferredSkinTone(for: $0)
        }
    }
}

private extension Emoji {

    var dictionaryKey: Emoji { neutralSkinToneVariant }
}
