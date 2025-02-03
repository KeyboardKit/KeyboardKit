//
//  KeyboardSettings+InputToolbarTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-03.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

final class KeyboardSettings_InputToolbarTests: XCTestCase {
    
    var settings: KeyboardSettings!
    
    override func setUp() {
        settings = .init()
    }
    
    override func tearDown() {
        settings.inputToolbarCharacters = ""
        settings.inputToolbarCharactersMaxLength = 10
        EmojiCategory.resetEmojis(in: .recent)
    }
    
    func mode(
        for type: KeyboardSettings.InputToolbarType
    ) -> Keyboard.InputToolbarDisplayMode {
        settings.inputToolbarType = type
        return settings.inputToolbarDisplayMode
    }
    
    func testCanResolveAllStaticInputToolbarTypes() {
        XCTAssertEqual(mode(for: .automatic), .automatic)
        XCTAssertEqual(mode(for: .numbers), .numbers)
        XCTAssertEqual(mode(for: .none), .none)
    }
    
    func testCanResolveCustomCharacters() {
        settings.inputToolbarCharacters = "abcdefghijklmnopq"
        XCTAssertEqual(mode(for: .characters), .characters("abcdefghij".chars))
        settings.inputToolbarCharactersMaxLength = 5
        XCTAssertEqual(mode(for: .characters), .characters("abcde".chars))
    }
    
    func testCanResolveRecentEmojis() {
        let emojiChars = "🚀👍🙌🙏⌨️👋💡🌱😂⚠️👑"
        let emojis = emojiChars.map { Emoji($0) }
        emojis.reversed().forEach { EmojiCategory.addEmoji($0, to: .recent) }
        XCTAssertEqual(mode(for: .recentEmojis), .characters("🚀👍🙌🙏⌨️👋💡🌱😂⚠️".chars))
        settings.inputToolbarCharactersMaxLength = 5
        XCTAssertEqual(mode(for: .recentEmojis), .characters("🚀👍🙌🙏⌨️".chars))
    }
}
