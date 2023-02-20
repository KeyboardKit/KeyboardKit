//
//  FrequentEmojiProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-16.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 a list of frequently used emojis.
 
 When using this protocol, you should trigger `registerEmoji`
 whenever a user selects an emoji, then use the registration
 to populate a frequent list that is returned by `emojis`.
*/
public protocol FrequentEmojiProvider: EmojiProvider {
    
    /**
     Register that an emoji has been used. This will be used
     to prepare the emojis that will be returned by `emojis`.
     */
    func registerEmoji(_ emoji: Emoji)
}
