//
//  EmojiProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-16.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to get a list of emojis.
*/
public protocol EmojiProvider {
    
    /// A list of emojis.
    var emojis: [Emoji] { get }
}
