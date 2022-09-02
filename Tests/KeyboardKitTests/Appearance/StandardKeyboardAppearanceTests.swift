//
//  StandardKeyboardAppearanceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import SwiftUI
import XCTest
@testable import KeyboardKit

class StandardKeyboardAppearanceTests: QuickSpec {

    override func spec() {
        
        var appearance: StandardKeyboardAppearance!
        var context: KeyboardContext!
        
        beforeEach {
            context = KeyboardContext()
            appearance = StandardKeyboardAppearance(context: context)
        }
        
        describe("action callout style") {
            
            it("is standard") {
                let result = appearance.actionCalloutStyle()
                let standard = ActionCalloutStyle.standard
                expect(result.callout).to(equal(standard.callout))
                expect(result.font).to(equal(standard.font))
                expect(result.selectedBackgroundColor).to(equal(standard.selectedBackgroundColor))
                expect(result.selectedForegroundColor).to(equal(standard.selectedForegroundColor))
                expect(result.verticalTextPadding).to(equal(standard.verticalTextPadding))
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
        
        describe("input callout style") {
            
            it("is standard") {
                let result = appearance.inputCalloutStyle()
                let standard = InputCalloutStyle.standard
                expect(result.callout).to(equal(standard.callout))
                expect(result.calloutSize).to(equal(standard.calloutSize))
                expect(result.font).to(equal(standard.font))
            }
        }
        
        describe("system keyboard button style") {
            
            var styles: [(action: KeyboardAction, style: KeyboardButtonStyle)]!
            
            let config = KeyboardLayoutConfiguration.standard(for: .preview)
            
            beforeEach {
                styles = KeyboardAction.testActions.map {
                    (action: $0, style: appearance.buttonStyle(for: $0, isPressed: false))
                }
            }
            
            describe("background color") {
                
                it("is standard for all actions except primary actions") {
                    styles.forEach {
                        let result = $0.style.backgroundColor
                        let expected: Color = $0.action.isPrimaryAction ?
                            .blue : $0.action.buttonBackgroundColor(for: context)
                        let equalOpaque = result == expected.opacity(1.00)
                        let equalTransparent = result == expected.opacity(0.95)
                        expect(equalOpaque || equalTransparent).to(beTrue())
                    }
                }
            }
            
            describe("border style") {
                
                it("is noStyle for some actions") {
                    styles.forEach {
                        switch $0.action {
                        case .none, .emoji, .emojiCategory: expect($0.style.border).to(equal(.noBorder))
                        default: expect($0.style.border).to(equal(.standard))
                        }
                    }
                }
            }
            
            describe("corner radius") {
                
                it("is standard for all actions") {
                    styles.forEach {
                        let result = $0.style.cornerRadius
                        let expected: CGFloat = config.buttonCornerRadius
                        expect(result).to(equal(expected))
                    }
                }
            }
            
            describe("font size") {
                
                func result(for action: KeyboardAction) -> CGFloat {
                    appearance.buttonFontSize(for: action)
                }
                
                it("is defined for actions with image") {
                    expect(result(for: .keyboardType(.email))).to(equal(20))
                    expect(result(for: .keyboardType(.emojis))).to(equal(20))
                    expect(result(for: .shift(currentState: .lowercased))).to(equal(20))
                    expect(result(for: .backspace)).to(equal(20))
                }
                
                it("is explicitly defined for some actions") {
                    expect(result(for: .keyboardType(.numeric))).to(equal(16))
                    expect(result(for: .return)).to(equal(16))
                    expect(result(for: .space)).to(equal(16))
                }
                
                it("is pattern-defined for some actions") {
                    expect(result(for: .character("a"))).to(equal(26))
                    expect(result(for: .character("A"))).to(equal(23))
                    expect(result(for: .character("!"))).to(equal(23))
                    expect(result(for: .return)).to(equal(16))
                    expect(result(for: .space)).to(equal(16))
                }
                
                it("has a default fallback size") {
                    expect(result(for: .emoji(Emoji("😃")))).to(equal(23))
                }
                
                it("is lightweight if action has image") {
                    let backspace = appearance.buttonStyle(for: .backspace, isPressed: false).font
                    let character = appearance.buttonStyle(for: .character(""), isPressed: false).font
                    expect(backspace).toNot(equal(character))
                }
            }
            
            describe("font weight") {
                
                func result(for action: KeyboardAction) -> Font.Weight? {
                    appearance.buttonFontWeight(for: action)
                }
                
                it("is light for actions with image and lower cased char") {
                    expect(result(for: .character("A"))).to(beNil())
                    expect(result(for: .character("a"))).to(equal(.light))
                    expect(result(for: .backspace)).to(equal(.light))
                }
            }
            
            describe("foreground color") {
            
                it("is standard for all actions except primary actions") {
                    styles.forEach {
                        let result = $0.style.foregroundColor
                        let expected: Color = $0.action.isPrimaryAction ? .white : $0.action.buttonForegroundColor(for: context)
                        expect(result).to(equal(expected))
                    }
                }
            }
            
            describe("shadow style") {
                
                it("is noStyle for some actions") {
                    styles.forEach {
                        switch $0.action {
                        case .none, .characterMargin(""), .emoji, .emojiCategory: expect($0.style.shadow).to(equal(.noShadow))
                        default: expect($0.style.shadow).to(equal(.standard))
                        }
                    }
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
