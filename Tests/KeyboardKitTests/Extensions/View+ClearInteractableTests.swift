//
//  View+ClearInteractableTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-06-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKitSwiftUI
import SwiftUI

class View_ClearInteractableTests: QuickSpec {

    override func spec() {
        
        describe("clear interactable background") {
            
            it("is defined") {
                let font = Text("").clearInteractableBackground()
                expect(font).toNot(beNil())
            }
        }
    }
}
