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

/// This protocol can be implemented by any type that can be
/// used to get a list of emojis.
///
/// If an emoji provider's ``canAddEmojis`` property returns
/// `true`, you can use ``addEmoji(_:)`` to add emojis to it,
/// and ``reset()`` to remove all emojis from it.
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

public extension EmojiProvider {

    @available(*, deprecated, renamed: "addEmoji")
    func registerEmoji(_ emoji: Emoji) {
        addEmoji(emoji)
    }
}
