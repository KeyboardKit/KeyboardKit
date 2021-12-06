//
//  Locale+LocalizedTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import KeyboardKit

class Locale_TextTests: QuickSpec {
    
    override func spec() {
        
        describe("localized name") {
            
            it("is valid") {
                let locale = Locale(identifier: "en-US")
                expect(locale.localizedName).to(equal("English (United States)"))
            }
        }
        
        describe("localized language name") {
            
            it("is valid") {
                let locale = Locale(identifier: "en-US")
                expect(locale.localizedLanguageName).to(equal("English"))
            }
        }
    }
}
