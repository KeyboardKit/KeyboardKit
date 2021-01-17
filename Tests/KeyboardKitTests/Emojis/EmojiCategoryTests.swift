//
//  EmojiCategoryTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import MockingKit

class EmojiCategoryTests: QuickSpec {
    
    override func spec() {
        
        describe("emoji category") {
            
            func fallbackEmoji(for category: EmojiCategory) -> String {
                category.fallbackDisplayEmoji
            }
            
            func firstEmoji(for category: EmojiCategory) -> String {
                category.emojis.first!
            }
            
            func firstEmojiAction(for category: EmojiCategory) -> KeyboardAction {
                category.emojiActions.first!
            }
            
            it("has built-in sort order") {
                let categories = EmojiCategory.all
                expect(categories).to(equal([
                    .frequent,
                    .smileys,
                    .animals,
                    .foods,
                    .activities,
                    .travels,
                    .objects,
                    .symbols,
                    .flags
                ]))
            }
            
            it("has a fallback display emoji") {
                expect(fallbackEmoji(for: .frequent)).to(equal("🕓"))
                expect(fallbackEmoji(for: .smileys)).to(equal("😀"))
                expect(fallbackEmoji(for: .animals)).to(equal("🐻"))
                expect(fallbackEmoji(for: .foods)).to(equal("🍔"))
                expect(fallbackEmoji(for: .activities)).to(equal("⚽️"))
                expect(fallbackEmoji(for: .travels)).to(equal("🚗"))
                expect(fallbackEmoji(for: .objects)).to(equal("💡"))
                expect(fallbackEmoji(for: .symbols)).to(equal("💱"))
                expect(fallbackEmoji(for: .flags)).to(equal("🏳️"))
            }
            
            it("contains the correct emojis") {
                expect(firstEmoji(for: .activities)).to(equal("⚽️"))
                expect(firstEmoji(for: .animals)).to(equal("🐶"))
                expect(firstEmoji(for: .flags)).to(equal("🏳️"))
                expect(firstEmoji(for: .foods)).to(equal("🍏"))
                expect(firstEmoji(for: .objects)).to(equal("⌚️"))
                expect(firstEmoji(for: .smileys)).to(equal("😀"))
                expect(firstEmoji(for: .symbols)).to(equal("❤️"))
                expect(firstEmoji(for: .travels)).to(equal("🚗"))
            }
            
            it("contains the correct emoji set") {
                expect(firstEmojiAction(for: .activities)).to(equal(.emoji("⚽️")))
                expect(firstEmojiAction(for: .animals)).to(equal(.emoji("🐶")))
                expect(firstEmojiAction(for: .flags)).to(equal(.emoji("🏳️")))
                expect(firstEmojiAction(for: .foods)).to(equal(.emoji("🍏")))
                expect(firstEmojiAction(for: .objects)).to(equal(.emoji("⌚️")))
                expect(firstEmojiAction(for: .smileys)).to(equal(.emoji("😀")))
                expect(firstEmojiAction(for: .symbols)).to(equal(.emoji("❤️")))
                expect(firstEmojiAction(for: .travels)).to(equal(.emoji("🚗")))
            }
        }
    }
}
