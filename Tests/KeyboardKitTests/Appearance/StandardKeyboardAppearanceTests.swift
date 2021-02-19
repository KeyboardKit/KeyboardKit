//
//  StandardKeyboardAppearanceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI

class StandardKeyboardAppearanceTests: QuickSpec {

    override func spec() {
        
        var appearance: KeyboardAppearance!
        var context: KeyboardContext!
        
        beforeEach {
            context = KeyboardContext(controller: MockKeyboardInputViewController())
            appearance = StandardKeyboardAppearance(context: context)
        }
        
        describe("keyboard background color") {
            
            it("is clear") {
                expect(appearance.keyboardBackgroundColor).to(equal(.clear))
            }
        }
        
        describe("button background color") {
            
            it("is standard for all actions except primary actions") {
                KeyboardAction.testActions.forEach {
                    let result = appearance.buttonBackgroundColor(for: $0, isPressed: false)
                    let expected: Color = $0.isPrimaryAction ? .blue : $0.standardButtonBackgroundColor(for: context)
                    expect(result).to(equal(expected))
                }
            }
        }
        
        describe("button corner radius") {
            
            it("is standard for all actions") {
                KeyboardAction.testActions.forEach {
                    let result = appearance.buttonCornerRadius(for: $0)
                    expect(result).to(equal(4))
                }
            }
        }
        
        describe("button font") {
            
            func result(for action: KeyboardAction) -> Font {
                appearance.buttonFont(for: action)
            }
            
            it("is lightweight if action has image") {
                expect(result(for: .backspace)).toNot(equal(result(for: .character(""))))
            }
        }
        
        describe("button foreground color") {
            
            it("is standard for all actions except primary actions") {
                KeyboardAction.testActions.forEach {
                    let result = appearance.buttonForegroundColor(for: $0, isPressed: false)
                    let expected: Color = $0.isPrimaryAction ? .white : $0.standardButtonForegroundColor(for: context)
                    expect(result).to(equal(expected))
                }
            }
        }
        
        describe("button image") {
            
            it("is standard for all actions") {
                KeyboardAction.testActions.forEach {
                    let result = appearance.buttonImage(for: $0)
                    let standard = $0.standardButtonImage
                    result.expectEqual(to: standard)
                }
            }
        }
        
        describe("button shadow color") {
            
            it("is standard for all actions") {
                KeyboardAction.testActions.forEach {
                    let result = appearance.buttonShadowColor(for: $0)
                    let standard = $0.standardButtonShadowColor(for: context)
                    expect(result).to(equal(standard))
                }
            }
        }
        
        describe("button text") {
            
            it("is standard for all actions") {
                KeyboardAction.testActions.forEach {
                    let result = appearance.buttonText(for: $0)
                    let standard = $0.standardButtonText(for: context)
                    result.expectEqual(to: standard)
                }
            }
        }
    }
}

private extension Optional where Wrapped: Equatable {
    
    func expectEqual(to: Self) {
        if self == nil {
            expect(to).to(beNil())
        } else {
            expect(self).to(equal(to))
        }
    }
}
