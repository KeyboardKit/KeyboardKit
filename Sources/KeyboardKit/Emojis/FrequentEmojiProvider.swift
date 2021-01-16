//
//  FrequentEmojiProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-16.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 a list of frequently used emojis.
 
 When implementing this protocol, you should register when a
 keyboard uses an emoji, then return a frequent list that is
 based on the user's history.
*/
public protocol FrequentEmojiProvider: EmojiProvider {
    
    func registerEmoji(_ emoji: String)
}
