//
//  KeyboardInputSetTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import Mockery
import UIKit

class KeyboardInputSetTests: QuickSpec {
    
    override func spec() {
        
        describe("english sets") {
            
            func rows(in set: KeyboardInputSet) -> Int {
                set.inputCharacters.count
            }
            
            it("are correctly setup") {
                expect(rows(in: .english)).to(equal(3))
                expect(rows(in: .englishNumeric)).to(equal(3))
                expect(rows(in: .englishSymbolic)).to(equal(3))
            }
        }
    }
}
