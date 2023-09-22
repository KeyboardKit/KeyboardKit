//
//  FrequentEmojiProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-16.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by types that can return a
 list of frequently used emojis.
 
 You should trigger `registerEmoji` whenever a user performs
 an action on an emoji, e.g. taps it in a emoji keyboard. It
 should cause the implementation to update its frequent info.
*/
public protocol FrequentEmojiProvider {
    
    /// A list of emojis.
    var emojis: [Emoji] { get }
    
    /// Register that an emoji has been used.
    func registerEmoji(_ emoji: Emoji)
}
