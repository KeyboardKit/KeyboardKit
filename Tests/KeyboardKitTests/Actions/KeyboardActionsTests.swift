//
//  KeyboardActionTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardActionTests: QuickSpec {
    
    override func spec() {
        
        describe("creating keyboard actions from string array") {
            
            it("converts strings to char actions") {
                let chars = ["a", "b", "c"]
                let row = KeyboardActions(characters: chars)
                expect(row.count).to(equal(3))
                expect(row[0]).to(equal(.character("a")))
                expect(row[1]).to(equal(.character("b")))
                expect(row[2]).to(equal(.character("c")))
            }
        }
        
        describe("creating keyboard actions from images") {
            
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
            
            it("converts arguments to image actions") {
                let actions = KeyboardActions(
                    imageNames: ["1", "2", "3"],
                    keyboardImageNamePrefix: "pre-",
                    keyboardImageNameSuffix: "-suf",
                    localizationKeyPrefix: "a-",
                    localizationKeySuffix: "-b",
                    throwAssertionFailure: false)
                
                expect(actions.count).to(equal(3))
                expect(verify(actions[0], "1", "pre-1-suf", "a-1-b")).to(beTrue())
                expect(verify(actions[1], "2", "pre-2-suf", "a-2-b")).to(beTrue())
                expect(verify(actions[2], "3", "pre-3-suf", "a-3-b")).to(beTrue())
            }
        }
    }
}
