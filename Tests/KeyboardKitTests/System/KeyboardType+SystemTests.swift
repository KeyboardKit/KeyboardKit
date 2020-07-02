//
//  KeyboardShiftState+SystemTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI

class KeyboardType_SystemTests: QuickSpec {

    override func spec() {
        
        describe("system keyboard button text") {
            
            func result(for type: KeyboardType) -> String? {
                type.systemKeyboardButtonText
            }
            
            it("is defined for some types") {
                expect(result(for: .numeric)).to(equal("123"))
                expect(result(for: .symbolic)).to(equal("#+="))
                
                expect(result(for: .alphabetic(.capsLocked))).to(beNil())
                expect(result(for: .alphabetic(.lowercased))).to(beNil())
                expect(result(for: .alphabetic(.uppercased))).to(beNil())
                expect(result(for: .custom(""))).to(beNil())
                expect(result(for: .email)).to(beNil())
                expect(result(for: .emojis)).to(beNil())
                expect(result(for: .images)).to(beNil())
            }
        }
    }
}
