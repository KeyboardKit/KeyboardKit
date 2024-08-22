//
//  EmojiProviders+BaseProvider.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-08-14.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, message: "The EmojiProvider concept will be removed in EmojiKit 1.0.")
public extension EmojiProviders {

    /// This is an emoji provider base class.
    class BaseProvider: EmojiProvider {

        /// Create an instance of the provider.
        ///
        /// - Parameters:
        ///   - maxCount: The max number of emojis to remember, by default `30`.
        ///   - defaults: The store used to persist emojis, by default `.standard`.
        ///   - defaultsKey: The store key used to persist emojis.
        public init(
            maxCount: Int? = nil,
            defaults: UserDefaults? = nil,
            defaultsKey: String
        ) {
            self.maxCount = maxCount ?? 30
            self.defaults = defaults ?? .standard
            self.defaultsKey = defaultsKey
        }

        /// The max number of emojis to remember.
        public let defaults: UserDefaults

        /// The store used to persist emojis.
        public let defaultsKey: String

        /// The store key used to persist emojis.
        public let maxCount: Int
    }
}

@available(*, deprecated, message: "The EmojiProvider concept will be removed in EmojiKit 1.0.")
public extension EmojiProviders.BaseProvider {

    var canAddEmojis: Bool { true }

    var emojis: [Emoji] {
        let chars = defaults.stringArray(forKey: defaultsKey) ?? []
        return chars.map { Emoji($0) }
    }

    func addEmoji(_ emoji: Emoji) {
        var emojis = self.emojis.filter { $0.char != emoji.char }
        emojis.insert(emoji, at: 0)
        let result = Array(emojis.prefix(maxCount))
        let chars = result.map { $0.char }
        defaults.set(chars, forKey: defaultsKey)
        defaults.synchronize()
    }

    func reset() {
        defaults.set([Emoji](), forKey: defaultsKey)
    }
}
