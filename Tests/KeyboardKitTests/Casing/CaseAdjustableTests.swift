//
//  CaseAdjustableTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class CaseAdjustableTests: QuickSpec {
    
    override func spec() {

        describe("case adjusted for text") {

            func result(for string: String, text: String) -> String {
                string.caseAdjusted(for: text)
            }

            it("is capitalized for single uppercased char") {
                let result = result(for: "testing this", text: "T")
                expect(result).to(equal("Testing This"))
            }

            it("is capitalized for capitalized text") {
                let result = result(for: "testing this", text: "Test")
                expect(result).to(equal("Testing This"))
            }

            it("is uppercased for uppercased text") {
                let result = result(for: "testing this", text: "TEST")
                expect(result).to(equal("TESTING THIS"))
            }

            it("is lowercased for lowercased text") {
                let result = result(for: "TESTING THIS", text: "test")
                expect(result).to(equal("testing this"))
            }
        }
    }
}
