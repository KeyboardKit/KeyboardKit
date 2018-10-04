//
//  Int+LimitTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class Int_LimitTests: QuickSpec {
    
    override func spec() {
        
        describe("limiting integer in range") {
            
            it("returns original value in range") {
                expect(5.limit(min: 0, max: 10)).to(equal(5))
            }
            
            it("returns min value if original value is too low") {
                expect((-1).limit(min: 0, max: 10)).to(equal(0))
            }
            
            it("returns max value if original value is too great") {
                expect(11.limit(min: 0, max: 10)).to(equal(10))
            }
        }
    }
}
