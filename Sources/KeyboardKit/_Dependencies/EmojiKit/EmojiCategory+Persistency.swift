//
//  EmojiCategory+Custom.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-08-23.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension EmojiCategory {

    /// A persisted list of emojis, that will be used by the
    /// ``EmojiCategory/favorites`` category.
    static var favoriteEmojis: [Emoji] {
        get { getPersistedEmojis(for: .favorites) }
        set { setPersistedEmojis(newValue, for: .favorites) }
    }

    /// A persisted list of emojis, that will be used by the
    /// ``EmojiCategory/frequent`` category.
    static var frequentEmojis: [Emoji] {
        get { getPersistedEmojis(for: .frequent) }
        set { setPersistedEmojis(newValue, for: .frequent) }
    }
}

public extension EmojiCategory {

    /// Add a certain emoji to a persisted category.
    static func addEmoji(
        _ emoji: Emoji,
        to category: PersistedCategory,
        maxCount: Int = 10_000
    ) {
        var emojis = getPersistedEmojis(for: category)
            .filter { $0 != emoji }
        emojis.insert(emoji, at: 0)
        let result = Array(emojis.prefix(maxCount))
        setPersistedEmojis(result, for: category)
    }

    /// Remove an emoji from a persisted category.
    static func removeEmoji(
        _ emoji: Emoji,
        from category: PersistedCategory
    ) {
        let emojis = getPersistedEmojis(for: category)
            .filter { $0 != emoji }
        setPersistedEmojis(emojis, for: category)
    }

    /// Reset the emojis in a persisted category.
    static func resetEmojis(
        in category: PersistedCategory
    ) {
        setPersistedEmojis([], for: category)
    }
}

public extension EmojiCategory {

    /// This enum defines all standard, persisted categories.
    enum PersistedCategory: Identifiable, Equatable {

        case favorites, frequent, custom(name: String)
    }
}

public extension EmojiCategory.PersistedCategory {

    var id: String { name }

    var name: String {
        switch self {
        case .favorites: "favorites"
        case .frequent: "frequent"
        case .custom(let name): name
        }
    }
}

extension EmojiCategory {

    /// Get a persisted list of emojis for a category.
    static func getPersistedEmojis(
        for category: PersistedCategory
    ) -> [Emoji] {
        let storage = persistedStorage
        let key = persistedStorageKey(for: category)
        let string = storage.stringArray(forKey: key) ?? []
        return string.map { Emoji($0) }
    }

    /// Get a persisted list of emojis for a category.
    static func setPersistedEmojis(
        _ emojis: [Emoji],
        for category: PersistedCategory
    ) {
        let storage = persistedStorage
        let key = persistedStorageKey(for: category)
        let chars = emojis.map { $0.char }
        return storage.set(chars, forKey: key)
    }

    /// Get the emojis storage key for custom category.
    ///
    /// > Important: This is currently read-only, but should
    /// be mutable in the future, to be able to customize it
    /// for other storage requirements, like App Groups.
    static var persistedStorage: UserDefaults {
        .standard
    }

    /// Get the emojis storage key for custom category.
    static func persistedStorageKey(
        for category: PersistedCategory
    ) -> String {
        "com.emojikit.category.\(category.name).emojis"
    }
}
