//
//  KeyboardAction+GridTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class KeyboardAction_GridTests: QuickSpec {
    
    override func spec() {
        
        describe("even for grid size") {
            
            it("doesn't add actions if not needed") {
                let array: [KeyboardAction] = [
                    .backspace, .backspace, .backspace, .backspace,
                    .backspace, .backspace, .backspace, .backspace
                ]
                let evened = array.evened(for: 4)
                expect(evened.count).to(equal(array.count))
            }
            
            it("adds none actions to the end of the array") {
                let array: [KeyboardAction] = [
                    .backspace, .backspace, .backspace, .backspace,
                    .backspace, .backspace
                ]
                let evened = array.evened(for: 4)
                expect(evened.count).to(equal(8))
                expect(evened[6]).to(equal(KeyboardAction.none))
                expect(evened[7]).to(equal(KeyboardAction.none))
            }
        }
    }
}
