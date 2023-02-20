//
//  MostRecentEmojiProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-16.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This emoji provider can be used to return the most recently
 used emojis.
 
 This class implements `FrequentEmojiProvider` but is simple
 compared to a real "frequent" provider, which should keep a
 list of recent and still relevant emojis, remember taps etc.
*/
public class MostRecentEmojiProvider: FrequentEmojiProvider {
    
    /**
     Create an instance of the provider.
     
     - Parameters:
       - maxCount: The max number of emojis to remember.
       - defaults: The store used to persist emojis.
     */
    public init(
        maxCount: Int = 30,
        defaults: UserDefaults = .standard
    ) {
        self.maxCount = maxCount
        self.defaults = defaults
    }
    
    private let defaults: UserDefaults
    private let maxCount: Int
    private let key = "com.keyboardkit.MostRecentEmojiProvider.emojis"
    
    /**
     The persisted emoji characters mapped to `Emoji` values.
     */
    public var emojis: [Emoji] {
        emojiChars.map { Emoji($0) }
    }
    
    /**
     The persisted emoji characters.
     */
    public var emojiChars: [String] {
        defaults.stringArray(forKey: key) ?? []
    }
    
    /**
     Register that an emoji has been used. This will be used
     to prepare the emojis that will be returned by `emojis`.
     */
    public func registerEmoji(_ emoji: Emoji) {
        var emojis = self.emojis.filter { $0.char != emoji.char }
        emojis.insert(emoji, at: 0)
        let result = Array(emojis.prefix(maxCount))
        let chars = result.map { $0.char }
        defaults.set(chars, forKey: key)
    }
}
