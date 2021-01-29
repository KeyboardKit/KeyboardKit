//
//  MockFrequentEmojiProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit
import UIKit

class MockFrequentEmojiProvider: Mock, FrequentEmojiProvider {
    
    lazy var registerEmojiRef = MockReference(registerEmoji)
    
    var emojis: [String] = []
    
    func registerEmoji(_ emoji: String) {
        invoke(registerEmojiRef, args: emoji)
    }
}
