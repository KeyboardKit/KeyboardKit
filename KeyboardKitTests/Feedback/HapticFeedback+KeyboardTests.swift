//
//  HapticFeedback+KeyboardTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class HapticFeedback_KeyboardTests: QuickSpec {
    
    override func spec() {
        
        describe("standard tap feedback") {
            
            it("is medium impact") {
                let feedback = HapticFeedback.standardTapFeedback
                expect(feedback).to(equal(.mediumImpact))
            }
        }
        
        describe("standard long press feedback") {
            
            it("is heavy impact") {
                let feedback = HapticFeedback.standardLongPressFeedback
                expect(feedback).to(equal(.heavyImpact))
            }
        }
    }
}
