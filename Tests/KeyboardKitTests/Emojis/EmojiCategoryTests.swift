//
//  EmojiCategoryTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import Mockery

class EmojiCategoryTests: QuickSpec {
    
    override func spec() {
        
        describe("emoji category") {
            
            func firstEmoji(for category: EmojiCategory) -> String {
                category.emojis.first!
            }
            
            func firstEmojiAction(for category: EmojiCategory) -> KeyboardAction {
                category.emojiActions.first!
            }
            
            it("has built-in sort order") {
                let categories = EmojiCategory.allCases
                expect(categories).to(equal([
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
                expect(firstEmojiAction(for: .activities)).to(equal(.character("⚽️")))
                expect(firstEmojiAction(for: .animals)).to(equal(.character("🐶")))
                expect(firstEmojiAction(for: .flags)).to(equal(.character("🏳️")))
                expect(firstEmojiAction(for: .foods)).to(equal(.character("🍏")))
                expect(firstEmojiAction(for: .objects)).to(equal(.character("⌚️")))
                expect(firstEmojiAction(for: .smileys)).to(equal(.character("😀")))
                expect(firstEmojiAction(for: .symbols)).to(equal(.character("❤️")))
                expect(firstEmojiAction(for: .travels)).to(equal(.character("🚗")))
            }
        }
    }
}
