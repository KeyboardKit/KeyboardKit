//
//  Emoji+MostRecent.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This provider can be used to get most recently used emojis.
 */
public class MostRecentEmojiProvider: FrequentEmojiProvider {
    
    /**
     Create an instance of the provider.
     
     - Parameters:
       - maxCount: The max number of emojis to remember, by default `30`.
       - defaults: The store used to persist emojis.
     */
    public init(
        maxCount: Int = 30,
        defaults: UserDefaults = .standard
    ) {
        self.maxCount = maxCount
        self.defaults = defaults
        self.key = Self.defaultsKey
    }
    
    private let defaults: UserDefaults
    private let maxCount: Int
    private let key: String
    
    static let defaultsKey = "com.emojikit.MostRecentEmojiProvider.emojis"
}

public extension MostRecentEmojiProvider {
    
    /// The most recently used emojis.
    var emojis: [Emoji] {
        emojiChars.map { Emoji($0) }
    }
    
    /// The persisted emoji characters.
    var emojiChars: [String] {
        defaults.stringArray(forKey: key) ?? []
    }
    
    /// Register that an emoji has been used.
    func registerEmoji(_ emoji: Emoji) {
        var emojis = self.emojis.filter { $0.char != emoji.char }
        emojis.insert(emoji, at: 0)
        let result = Array(emojis.prefix(maxCount))
        let chars = result.map { $0.char }
        defaults.set(chars, forKey: key)
        defaults.synchronize()
    }
    
    /// Reset the underlying data source.
    func reset() {
        defaults.set([Emoji](), forKey: key)
    }
}
