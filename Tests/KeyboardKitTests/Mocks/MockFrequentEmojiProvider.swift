//
//  MockFrequentEmojiProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

class MockFrequentEmojiProvider: Mock, FrequentEmojiProvider {
    
    lazy var registerEmojiRef = MockReference(registerEmoji)
    
    var emojis: [Emoji] = []
    
    func registerEmoji(_ emoji: Emoji) {
        call(registerEmojiRef, args: emoji)
    }
}
