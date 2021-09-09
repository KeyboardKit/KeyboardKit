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
        
        describe("system keyboard button style") {
            
            var styles: [(action: KeyboardAction, style: SystemKeyboardButtonStyle)]!
            
            beforeEach {
                styles = KeyboardAction.testActions.map {
                    (action: $0, style: appearance.systemKeyboardButtonStyle(for: $0, isPressed: false))
                }
            }
            
            it("backgroundColor is standard for all actions except primary actions") {
                styles.forEach {
                    let result = $0.style.backgroundColor
                    let expected: Color = $0.action.isPrimaryAction ? .blue : $0.action.standardButtonBackgroundColor(for: context)
                    expect(result).to(equal(expected))
                }
            }
            
            it("buttonCornerRadius is standard for all actions") {
                styles.forEach {
                    let result = $0.style.cornerRadius
                    let expected: CGFloat = .standardKeyboardButtonCornerRadius(for: context.device)
                    expect(result).to(equal(expected))
                }
            }
            
            it("buttonForegroundColor is standard for all actions except primary actions") {
                styles.forEach {
                    let result = $0.style.foregroundColor
                    let expected: Color = $0.action.isPrimaryAction ? .white : $0.action.standardButtonForegroundColor(for: context)
                    expect(result).to(equal(expected))
                }
            }
            
            it("buttonShadowColor is standard for all actions") {
                styles.forEach {
                    let result = $0.style.shadow.color
                    let standard = $0.action.standardButtonShadowColor(for: context)
                    expect(result).to(equal(standard))
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
        
        describe("button image") {
            
            it("is standard for all actions") {
                KeyboardAction.testActions.forEach {
                    let result = appearance.buttonImage(for: $0)
                    let standard = $0.standardButtonImage(for: context)
                    result.expectEqual(to: standard)
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
