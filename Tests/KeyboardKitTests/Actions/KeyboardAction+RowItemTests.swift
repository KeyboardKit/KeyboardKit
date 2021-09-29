//
//  KeyboardAction+RowItemTest.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardAction_RowItemTests: QuickSpec {
    
    override func spec() {
        
        describe("row id") {
            
            it("uses itself as id") {
                KeyboardAction.testActions.forEach {
                    expect($0.rowId).to(equal($0))
                }
            }
        }
    }
}
