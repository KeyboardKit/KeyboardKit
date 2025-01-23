//
//  UTType+EmojiKit.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2024-12-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import UniformTypeIdentifiers

public extension UTType {
    
    /// A custom uniform type for an ``Emoji``.
    ///
    /// The explicit type ID is `com.emojikit.emoji`.
    static var emoji: UTType {
        .init(
            exportedAs: "com.emojikit.emoji",
            conformingTo: .data
        )
    }
    
    /// A custom uniform type for an ``EmojiCategory``.
    ///
    /// The explicit type ID is `com.emojikit.emojicategory`.
    static var emojiCategory: UTType {
        .init(
            exportedAs: "com.emojikit.emojicategory",
            conformingTo: .data
        )
    }
}
