//
//  EmojiProviders+FavoriteProvider.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-08-14.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, message: "The EmojiProvider concept will be removed in EmojiKit 1.0.")
public extension EmojiProviders {

    /// This emoji provider provides favorite emojis.
    class FavoriteProvider: EmojiProviders.BaseProvider {

        /// Create a favorite emoji provider.
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
                defaultsKey: defaultsKey ?? "com.emojikit.emojis.favorite"
            )
        }
    }
}

@available(*, deprecated, message: "The EmojiProvider concept will be removed in EmojiKit 1.0.")
public extension EmojiProvider where Self == EmojiProviders.FavoriteProvider {

    /// Create a favorite emoji provider.
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
