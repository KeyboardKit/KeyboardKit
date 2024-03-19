//
//  FrequentEmojiProvider.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by types that can return a
 list of frequently used emojis.
 
 Call `registerEmoji` when an emoji is used, to register the
 emoji and update the provider.
 
 The ``Emoji/frequentEmojiProvider`` is automatically set to
 a ``MostRecentEmojiProvider`` but you can replace it with a
 custom provider at any time.
*/
public protocol FrequentEmojiProvider {
    
    /// A list of frequently used emojis.
    var emojis: [Emoji] { get }
    
    /// Register that an emoji has been used.
    func registerEmoji(_ emoji: Emoji)
    
    /// Reset the underlying data source.
    func reset()
}

public extension Emoji {
    
    /// The standard frequent emoji provider.
    static var frequentEmojiProvider: FrequentEmojiProvider = MostRecentEmojiProvider()
}
