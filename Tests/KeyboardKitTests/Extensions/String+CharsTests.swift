//
//  String+Chars.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-12-31.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class String_CharsTests: QuickSpec {
    
    override func spec() {
        
        describe("chars") {
            
            it("splits the string into individual characters") {
                let string = "foo"
                let result = string.chars
                expect(result).to(equal(["f", "o", "o"]))
            }
        }
        
        describe("static character collection") {
            
            it("has valid values") {
                expect(String.carriageReturn).to(equal("\r"))
                expect(String.newline).to(equal("\n"))
                expect(String.space).to(equal(" "))
                expect(String.tab).to(equal("\t"))
                expect(String.zeroWidthSpace).to(equal("\u{200B}"))
            }
        }
    }
}
