//
//  KeyboardShiftState+ButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI

class KeyboardShiftState_ButtonTests: QuickSpec {

    override func spec() {
        
        describe("standard button image") {
            
            func result(for state: KeyboardShiftState) -> Image {
                state.standardButtonImage
            }
            
            it("is defined for all states") {
                expect(result(for: .capsLocked)).to(equal(.shiftCapslocked))
                expect(result(for: .lowercased)).to(equal(.shiftLowercased))
                expect(result(for: .uppercased)).to(equal(.shiftUppercased))
            }
        }
    }
}
