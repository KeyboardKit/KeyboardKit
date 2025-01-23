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
    /// For instance, the ``recent`` category should get the
    /// emoji added firstmost, while ``frequent`` should use
    /// a more sophisticated algorithm and take frequency in
    /// consideration when updating the category.
    ///
    /// Since EmojiKit does not have algoritms for frequency
    /// calculations, this function will just apply the same
    /// changes to both ``recent`` and ``frequent``. You can
    /// however use the ``frequent`` category if you want to
    /// implement your own frequency logic.
    func registerUserSelection() {
        EmojiCategory.addEmoji(self, to: .recent)
        EmojiCategory.addEmoji(self, to: .frequent)
    }
}
