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
    /// This will insert the selected emoji first within the
    /// ``EmojiCategory/Persisted/recent`` category.
    func registerUserSelection() {
        EmojiCategory.Persisted.recent.addEmoji(self)
    }
}
