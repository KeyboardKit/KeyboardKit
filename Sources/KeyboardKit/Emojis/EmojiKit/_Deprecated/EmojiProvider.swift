//
//  EmojiProvider.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, renamed: "EmojiProvider")
public typealias FrequentEmojiProvider = EmojiProvider

@available(*, deprecated, message: "The EmojiProvider concept will be removed in EmojiKit 1.0.")
public protocol EmojiProvider {

    /// Whether the provider can add custom emojis.
    var canAddEmojis: Bool { get }

    /// A list of emojis.
    var emojis: [Emoji] { get }
    
    /// Add an emoji to the provider.
    func addEmoji(_ emoji: Emoji)

    /// Reset the provider.
    func reset()
}

@available(*, deprecated, message: "The EmojiProvider concept will be removed in EmojiKit 1.0.")
public extension EmojiProvider {

    func registerEmoji(_ emoji: Emoji) {
        addEmoji(emoji)
    }
}
