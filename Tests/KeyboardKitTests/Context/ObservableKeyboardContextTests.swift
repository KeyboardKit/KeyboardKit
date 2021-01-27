//
//  ObservableKeyboardContextTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI
import UIKit

class ObservableKeyboardContextTests: QuickSpec {

    override func spec() {
        
        describe("context") {
            
            it("can be created with context") {
                let standard = StandardKeyboardContext(
                    controller: KeyboardInputViewController(),
                    actionHandler: MockKeyboardActionHandler(),
                    keyboardType: .email)
                standard.emojiCategory = .animals
                standard.hasFullAccess = true
                standard.needsInputModeSwitchKey = true
                
                let context = ObservableKeyboardContext(from: standard)
                expect(context.actionHandler).to(be(standard.actionHandler))
                expect(context.controller).to(be(standard.controller))
                expect(context.hasDictationKey).to(equal(standard.hasDictationKey))
                expect(context.hasFullAccess).to(equal(standard.hasFullAccess))
                expect(context.keyboardInputSetProvider).to(be(standard.keyboardInputSetProvider))
                expect(context.keyboardLayoutProvider).to(be(standard.keyboardLayoutProvider))
                expect(context.keyboardType).to(equal(standard.keyboardType))
                expect(context.needsInputModeSwitchKey).to(equal(standard.needsInputModeSwitchKey))
                expect(context.primaryLanguage).to(beNil())
                expect(context.textDocumentProxy).to(be(standard.textDocumentProxy))
                expect(context.textInputMode).to(beNil())
            }
        }
    }
}
