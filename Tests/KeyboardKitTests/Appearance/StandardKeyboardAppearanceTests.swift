//
//  StandardKeyboardAppearanceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import XCTest

@testable import KeyboardKit

class StandardKeyboardAppearanceTests: XCTestCase {

    var appearance: StandardKeyboardAppearance!
    var context: KeyboardContext!

    var styles: [(action: KeyboardAction, style: KeyboardButtonStyle)]!
    let config = KeyboardLayoutConfiguration.standard(for: .preview)

    override func setUp() {
        context = KeyboardContext()
        appearance = StandardKeyboardAppearance(keyboardContext: context)
        styles = KeyboardAction.testActions.map {
            (action: $0, style: appearance.buttonStyle(for: $0, isPressed: false))
        }
    }


    func buttonFontSize(for action: KeyboardAction) -> CGFloat {
        appearance.buttonFontSize(for: action)
    }

    func buttonFontWeight(for action: KeyboardAction) -> Font.Weight? {
        appearance.buttonFontWeight(for: action)
    }


    func testActionCalloutStyleIsStandard() {
        let result = appearance.actionCalloutStyle()
        let standard = ActionCalloutStyle.standard
        XCTAssertEqual(result.callout, standard.callout)
        XCTAssertEqual(result.font, standard.font)
        XCTAssertEqual(result.selectedBackgroundColor, standard.selectedBackgroundColor)
        XCTAssertEqual(result.selectedForegroundColor, standard.selectedForegroundColor)
        XCTAssertEqual(result.verticalTextPadding, standard.verticalTextPadding)
    }

    func testButtonImageIsStandardForAllActions() {
        KeyboardAction.testActions.forEach {
            let result = appearance.buttonImage(for: $0)
            let standard = $0.standardButtonImage(for: context)
            result.expectEqual(to: standard)
        }
    }

    func testButtonTextIsStandardForAllActions() {
        KeyboardAction.testActions.forEach {
            let result = appearance.buttonText(for: $0)
            let standard = $0.standardButtonText(for: context)
            result.expectEqual(to: standard)
        }
    }

    func testInputCalloutStyleIsStandard() {
        let result = appearance.inputCalloutStyle()
        let standard = InputCalloutStyle.standard
        XCTAssertEqual(result.callout, standard.callout)
        XCTAssertEqual(result.calloutSize, standard.calloutSize)
        XCTAssertEqual(result.font, standard.font)
    }


    func testButtonStyleBackgroundColorIsStandardForAllExceptPrimaryAction() {
        styles.forEach {
            let result = $0.style.backgroundColor
            let isPrimary = $0.action.isPrimaryAction
            let isSystem = $0.action.isSystemAction
            let expectedBlue = isPrimary && !isSystem
            let expected: Color = expectedBlue ? .blue : $0.action.buttonBackgroundColor(for: context)
            let equalOpaque = result == expected.opacity(1.00)
            let equalTransparent = result == expected.opacity(0.95)
            XCTAssertTrue(equalOpaque || equalTransparent)
        }
    }

    func testButtonStyleBorderIsNoStyleForSomeActions() {
        styles.forEach {
            switch $0.action {
            case .none, .emoji, .emojiCategory:
                XCTAssertEqual($0.style.border, .noBorder)
            default: XCTAssertEqual($0.style.border, .standard)
            }
        }
    }

    func testButtonStyleCornerRadiusIsStandardForAllActions() {
        styles.forEach {
            let result = $0.style.cornerRadius
            let expected: CGFloat = config.buttonCornerRadius
            XCTAssertEqual(result, expected)
        }
    }

    func testButtonFontSizeIsDefinedForActionsWithImage() {
        XCTAssertEqual(buttonFontSize(for: .keyboardType(.email)), 20)
        XCTAssertEqual(buttonFontSize(for: .keyboardType(.emojis)), 20)
        XCTAssertEqual(buttonFontSize(for: .shift(currentState: .lowercased)), 20)
        XCTAssertEqual(buttonFontSize(for: .backspace), 20)
    }

    func testButtonFontSizeIsExplicitlyDefinedForSomeActions() {
        XCTAssertEqual(buttonFontSize(for: .keyboardType(.alphabetic(.lowercased))), 15)
        XCTAssertEqual(buttonFontSize(for: .keyboardType(.numeric)), 16)
        XCTAssertEqual(buttonFontSize(for: .keyboardType(.symbolic)), 14)
        XCTAssertEqual(buttonFontSize(for: .primary(.return)), 16)
        XCTAssertEqual(buttonFontSize(for: .space), 16)
    }

    func testButtonFontSizeIsPatternDefinedForSomeActions() {
        XCTAssertEqual(buttonFontSize(for: .character("a")), 26)
        XCTAssertEqual(buttonFontSize(for: .character("A")), 23)
        XCTAssertEqual(buttonFontSize(for: .character("!")), 23)
        XCTAssertEqual(buttonFontSize(for: .primary(.return)), 16)
        XCTAssertEqual(buttonFontSize(for: .space), 16)
    }

    func testButtonFontSizeHasDefaultFallbackSize() {
        XCTAssertEqual(buttonFontSize(for: .emoji(Emoji("😃"))), 23)
    }

    func testButtonStyleIsLightweightIfActionHasImage() {
        let backspace = appearance.buttonStyle(for: .backspace, isPressed: false).font
        let character = appearance.buttonStyle(for: .character(""), isPressed: false).font
        XCTAssertNotEqual(backspace, character)
    }

    func testButtonFontWeightIsLightForActionsWithImageAndLowerCasedChar() {
        XCTAssertNil(buttonFontWeight(for: .character("A")))
        XCTAssertEqual(buttonFontWeight(for: .character("a")), .light)
        XCTAssertEqual(buttonFontWeight(for: .backspace), .light)
    }

    func testButtonStyleForegroundColorIsStandardForAllActionsExceptPrimaryActions() {
        styles.forEach {
            let result = $0.style.foregroundColor
            let isPrimary = $0.action.isPrimaryAction
            let isSystem = $0.action.isSystemAction
            let expectedWhite = isPrimary && !isSystem
            let expected: Color = expectedWhite ? .white : $0.action.buttonForegroundColor(for: context)
            XCTAssertEqual(result, expected)
        }
    }

    func testButtonStyleShadowStyleIsNoStyleForSomeActions() {
        styles.forEach {
            switch $0.action {
            case .none, .characterMargin(""), .emoji, .emojiCategory:
                XCTAssertEqual($0.style.shadow, .noShadow)
            default: XCTAssertEqual($0.style.shadow, .standard)
            }
        }
    }
}

private extension Optional where Wrapped: Equatable {
    
    func expectEqual(to: Self) {
        if self == nil {
            XCTAssertNil(to)
        } else {
            XCTAssertEqual(self, to)
        }
    }
}
