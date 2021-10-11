//
//  KeyboardAction+InputCalloutTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardAction_InputCalloutTests: QuickSpec {
    
    override func spec() {
        
        describe("input callout text") {
            
            it("is only specified for character action") {
                let action = KeyboardAction.character("foo")
                let others = KeyboardAction.testActions.filter { !$0.isCharacterAction }
                expect(action.inputCalloutText).to(equal("foo"))
                others.forEach {
                    expect($0.inputCalloutText).to(beNil())
                }
            }
        }
    }
}
