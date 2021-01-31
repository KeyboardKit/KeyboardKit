//
//  Emoji.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct is just a wrapper around a single character. It
 can be used to get a little bit of type safety, and to work
 more structured with emojis.
 */
public struct Emoji: Equatable {
    
    public init(_ char: String) {
        self.char = char
    }
   
    public let char: String
}

public extension Emoji {
    
    /**
     Get all emojis from all categories.
     */
    static var all: [Emoji] {
        EmojiCategory.all.flatMap { $0.emojis }
    }
}
