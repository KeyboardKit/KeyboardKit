//
//  EmojiCategory+Persisted.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-08-23.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, message: "Use the new EmojiCategory.Persisted instead.")
public extension EmojiCategory {

    /// This enum defines all standard, persisted categories.
    enum PersistedCategory: CaseIterable, Identifiable, Equatable {

        case favorites
        case frequent
        case recent
        case custom(name: String)
    }
}

@available(*, deprecated, message: "Use the new EmojiCategory.Persisted instead.")
public extension EmojiCategory {
    
    /// A persisted list of emojis, used by ``favorites``.
    static var favoriteEmojis: [Emoji] {
        get { getEmojis(for: .favorites) }
        set { setEmojis(newValue, for: .favorites) }
    }
    
    /// A persisted list of emojis, used by ``frequent``.
    static var frequentEmojis: [Emoji] {
        get { getEmojis(for: .frequent) }
        set { setEmojis(newValue, for: .frequent) }
    }
    
    /// A persisted list of emojis, used by ``recent``.
    static var recentEmojis: [Emoji] {
        get { getEmojis(for: .recent) }
        set { setEmojis(newValue, for: .recent) }
    }
}

@available(*, deprecated, message: "Use the new EmojiCategory.Persisted instead.")
public extension EmojiCategory {

    /// Add a certain emoji to a persisted category.
    static func addEmoji(
        _ emoji: Emoji,
        to category: PersistedCategory,
        maxCount: Int? = nil
    ) {
        var emojis = getEmojis(for: category)
            .filter { $0 != emoji }
        emojis.insert(emoji, at: 0)
        setEmojis(emojis, for: category, maxCount: maxCount)
    }
    
    /// Get the persisted emojis for a category.
    static func getEmojis(
        for category: PersistedCategory
    ) -> [Emoji] {
        let key = storageKey(for: category, value: .emojis)
        let value = storage.stringArray(forKey: key) ?? []
        return value.map { Emoji($0) }
    }
    
    /// Get the persisted emoji max count for a category.
    static func getEmojisMaxCount(
        for category: PersistedCategory
    ) -> Int {
        let key = storageKey(for: category, value: .emojisMaxCount)
        let value = storage.integer(forKey: key)
        return value < 1 ? 1_000 : value
    }

    /// Remove an emoji from a persisted category.
    static func removeEmoji(
        _ emoji: Emoji,
        from category: PersistedCategory
    ) {
        let emojis = getEmojis(for: category)
            .filter { $0 != emoji }
        setEmojis(emojis, for: category)
    }
    
    /// Reset the emojis in a persisted category.
    static func resetEmojis(
        for category: PersistedCategory
    ) {
        setEmojis([], for: category)
    }

    /// Set the persisted emojis for a category.
    static func setEmojis(
        _ emojis: [Emoji],
        for category: PersistedCategory,
        maxCount: Int? = nil
    ) {
        let key = storageKey(for: category, value: .emojis)
        let emojiChars = emojis.map { $0.char }
        let defaultMaxCount = getEmojisMaxCount(for: category)
        let value = Array(emojiChars.prefix(maxCount ?? defaultMaxCount))
        return storage.set(value, forKey: key)
    }

    /// Set the persisted emojis for a category.
    static func setEmojisMaxCount(
        _ count: Int,
        for category: PersistedCategory
    ) {
        let key = storageKey(for: category, value: .emojisMaxCount)
        return storage.set(count, forKey: key)
    }
}

@available(*, deprecated, message: "Use the new EmojiCategory.Persisted instead.")
public extension EmojiCategory.PersistedCategory {

    var id: String { name }

    var name: String {
        switch self {
        case .favorites: "favorites"
        case .frequent: "frequent"
        case .recent: "recent"
        case .custom(let name): name
        }
    }
    
    static var allCases: [EmojiCategory.PersistedCategory] {
        [.favorites, .frequent, .recent]
    }
}

private extension String {
    
    static let emojis = "emojis"
    static let emojisMaxCount = "emojisMaxCount"
}

@available(*, deprecated, message: "Use the new EmojiCategory.Persisted instead.")
extension EmojiCategory {

    /// Get the emojis storage key for custom category.
    ///
    /// > Note: This should be mutable, to allow customizing
    /// it for other storage requirements, like App Groups.
    static var storage: UserDefaults {
        .standard
    }
    
    /// Get a storage value key for a certain category.
    static func storageKey(
        for category: EmojiCategory.PersistedCategory,
        value: String
    ) -> String {
        "com.emojikit.category.\(category.name).\(value)"
    }
}
