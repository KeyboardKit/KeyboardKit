//
//  ImageActionKeyboardTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardImageActionsTests: QuickSpec {
    
    override func spec() {
        
        describe("image actions") {
            
            func verify(
                _ action: KeyboardAction,
                _ imageName: String,
                _ keyboardImageName: String,
                _ description: String) -> Bool {
                switch action {
                case .image(let imageName, let keyboardImageName, let description):
                    return imageName == imageName
                        && keyboardImageName == keyboardImageName
                        && description == description
                default: return false
                }

            }
            
            it("is correctly created") {
                let actions = KeyboardImageActions(
                    imageNames: ["1", "2", "3"],
                    keyboardImageNamePrefix: "pre-",
                    keyboardImageNameSuffix: "-suf",
                    localizationKeyPrefix: "a-",
                    localizationKeySuffix: "-b",
                    throwAssertionFailure: false).actions
                
                expect(actions.count).to(equal(3))
                expect(verify(actions[0], "1", "pre-1-suf", "a-1-b")).to(beTrue())
                expect(verify(actions[1], "2", "pre-2-suf", "a-2-b")).to(beTrue())
                expect(verify(actions[2], "3", "pre-3-suf", "a-3-b")).to(beTrue())
            }
        }
    }
}
