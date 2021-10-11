//
//  KeyboardInputTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardInputTests: QuickSpec {
    
    override func spec() {
        
        describe("character for casing") {
            
            it("returns the correct char") {
                let input = KeyboardInput(neutral: "n", uppercased: "u", lowercased: "l")
                expect(input.character(for: .auto)).to(equal("l"))
                expect(input.character(for: .lowercased)).to(equal("l"))
                expect(input.character(for: .uppercased)).to(equal("u"))
                expect(input.character(for: .capsLocked)).to(equal("u"))
            }
        }
    }
}
