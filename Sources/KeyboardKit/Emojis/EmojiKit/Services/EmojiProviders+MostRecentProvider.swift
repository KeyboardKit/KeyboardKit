//
//  EmojiProviders+MostRecentProvider.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, renamed: "EmojiProviders.MostRecentProvider")
public typealias MostRecentEmojiProvider = EmojiProviders.MostRecentProvider

public extension EmojiProviders {

    /// This emoji provider provides the most recent emojis.
    class MostRecentProvider: EmojiProviders.BaseProvider {

        /// Create a most recent emoji provider.
        ///
        /// - Parameters:
        ///   - maxCount: The max number of emojis to remember, by default `30`.
        ///   - defaults: The store used to persist emojis, by default `.standard`.
        ///   - defaultsKey: The store key used to persist emojis, by default an EmojiKit-specific value.
        public override init(
            maxCount: Int? = nil,
            defaults: UserDefaults? = nil,
            defaultsKey: String? = nil
        ) {
            super.init(
                maxCount: maxCount,
                defaults: defaults,
                defaultsKey: defaultsKey ?? "com.emojikit.MostRecentEmojiProvider.emojis"
            )
        }
    }
}

public extension EmojiProvider where Self == EmojiProviders.MostRecentProvider {

    /// Create a most recent emoji provider.
    ///
    /// - Parameters:
    ///   - maxCount: The max number of emojis to remember, by default `30`.
    ///   - defaults: The store used to persist emojis, by default `.standard`.
    ///   - defaultsKey: The store key used to persist emojis, by default an EmojiKit-specific value.
    static func favorite(
        maxCount: Int? = nil,
        defaults: UserDefaults? = nil,
        defaultsKey: String? = nil
    ) -> Self {
        Self.init(maxCount: maxCount, defaults: defaults, defaultsKey: defaultsKey)
    }
}
