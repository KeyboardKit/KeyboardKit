//
//  Emoji+Selection.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2025-01-08.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Emoji {
    
    /// Register a user selection for the emoji.
    ///
    /// This will update some of the customizable categories
    /// according to how they should be affected when a user
    /// selects an emoji.
    ///
    /// For instance, the recent category will add the emoji
    /// first, while the frequent category should use a more
    /// sophisticated way to take frequency in consideration.
    ///
    /// Since EmojiKit does not yet have an algoritm for the
    /// frequency calculations, this function will currently
    /// apply the same changes to both categories.
    func registerUserSelection() {
        EmojiCategory.addEmoji(self, to: .recent)
        EmojiCategory.addEmoji(self, to: .frequent)
    }
}
