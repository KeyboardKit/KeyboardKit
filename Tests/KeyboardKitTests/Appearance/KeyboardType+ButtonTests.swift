//
//  KeyboardCasing+ButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI

class KeyboardType_ButtonTests: QuickSpec {

    override func spec() {
        
        describe("system keyboard button font size") {
            
            func result(for type: KeyboardType) -> CGFloat {
                type.standardButtonFontSize(for: KeyboardContext.preview)
            }
            
            it("is defined for all types") {
                expect(result(for: .alphabetic(.lowercased))).to(equal(15))
                expect(result(for: .numeric)).to(equal(16))
                expect(result(for: .symbolic)).to(equal(14))
                
                expect(result(for: .email)).to(equal(14))
                expect(result(for: .emojis)).to(equal(14))
                expect(result(for: .custom(""))).to(equal(14))
                expect(result(for: .images)).to(equal(14))
            }
        }
        
        describe("system keyboard button image") {
            
            func result(for type: KeyboardType) -> Image? {
                type.standardButtonImage
            }
            
            it("is defined for some types") {
                expect(result(for: .email)).to(equal(.email))
                expect(result(for: .emojis)).to(equal(.emoji))
                expect(result(for: .images)).to(equal(.images))
                
                expect(result(for: .alphabetic(.lowercased))).to(beNil())
                expect(result(for: .custom(""))).to(beNil())
                expect(result(for: .numeric)).to(beNil())
                expect(result(for: .symbolic)).to(beNil())
            }
        }
        
        describe("system keyboard button text") {
            
            func result(for type: KeyboardType) -> String? {
                type.standardButtonText(for: .preview)
            }
            
            it("is defined for some types") {
                expect(result(for: .alphabetic(.lowercased))).to(equal("ABC"))
                expect(result(for: .numeric)).to(equal("123"))
                expect(result(for: .symbolic)).to(equal("#+="))
                
                expect(result(for: .email)).to(beNil())
                expect(result(for: .emojis)).to(beNil())
                expect(result(for: .custom(""))).to(beNil())
                expect(result(for: .images)).to(beNil())
            }
        }
    }
}
