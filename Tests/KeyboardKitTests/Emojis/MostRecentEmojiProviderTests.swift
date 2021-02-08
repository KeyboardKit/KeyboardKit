//
//  MostRecentEmojiProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-16.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockingKit
@testable import KeyboardKit

class MostRecentEmojiProviderTests: QuickSpec {
    
    override func spec() {
        
        var defaults: MockUserDefaults!
        var provider: MostRecentEmojiProvider!
        
        beforeEach {
            defaults = MockUserDefaults()
            provider = MostRecentEmojiProvider(defaults: defaults)
        }
        
        describe("most recent emojis") {
            
            it("is empty by default") {
                expect(provider.emojis).to(equal([]))
            }
            
            it("returns anything stored in defaults") {
                let list = ["a", "b", "c"]
                defaults.registerResult(for: defaults.stringArrayRef) { _ in list }
                expect(provider.emojis.map { $0.char }).to(equal(list))
            }
        }
        
        describe("regitering emoji") {
            
            it("stores new emoji firstmost in user defaults") {
                let list = ["a", "b", "c"]
                defaults.registerResult(for: defaults.stringArrayRef) { _ in list }
                provider.registerEmoji(Emoji("c"))
                let read = defaults.calls(to: defaults.stringArrayRef)
                let write = defaults.calls(to: defaults.setValueRef)
                expect(read.count).to(equal(1))
                expect(write.count).to(equal(1))
                expect(write[0].arguments.0 as? [String]).to(equal(["c", "a", "b"]))
                expect(write[0].arguments.1).to(equal(read[0].arguments))
            }
            
            it("caps new emoji list to max count") {
                let list = Array(repeating: "a", count: 100)
                defaults.registerResult(for: defaults.stringArrayRef) { _ in list }
                provider.registerEmoji(Emoji("c"))
                let calls = defaults.calls(to: defaults.setValueRef)
                let written = calls[0].arguments.0 as? [String]
                expect(written?.count).to(equal(30))
            }
        }
    }
}
