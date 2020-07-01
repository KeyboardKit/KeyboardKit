//
//  KeyboardAction+SystemTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class KeyboardAction_SystemTests: QuickSpec {
    
    override func spec() {
        
        let actions = KeyboardAction.testActions
        
        var expected: [KeyboardAction]! {
            didSet {
                unexpected = actions
                expected.forEach { action in
                    unexpected.removeAll { $0 == action }
                }
            }
        }
        
        var unexpected: [KeyboardAction]!
        
        beforeEach {
            expected = []
            unexpected = []
        }
        
        describe("system font") {
            
            it("is defined for all actions") {
                actions.forEach {
                    expect($0.systemFont).to(equal(UIFont.preferredFont(forTextStyle: $0.systemTextStyle)))
                }
            }
        }
        
        describe("system text style") {
            
            it("is custom for some actions, but defined for all") {
                actions.forEach {
                    if $0 == .emoji("") {
                        expect($0.systemTextStyle).to(equal(.title1))
                    } else {
                        expect($0.systemTextStyle).to(equal(.title2))
                    }
                }
            }
        }
    }
}
