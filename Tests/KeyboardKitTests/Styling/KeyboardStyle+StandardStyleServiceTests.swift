//
//  KeyboardStyle+StandardStyleServiceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import XCTest

@testable import KeyboardKit

class KeyboardStyle_StandardStyleServiceTests: XCTestCase {

    var service: KeyboardStyle.StandardStyleService!
    var context: KeyboardContext!
    var config: KeyboardLayout.DeviceConfiguration!
    var styles: [(action: KeyboardAction, style: Keyboard.ButtonStyle)]!

    override func setUp() {
        context = KeyboardContext()
        context.setIsLiquidGlassEnabled(false)
        config = .standard(for: context)
        service = .init(keyboardContext: context)
        styles = KeyboardAction.testActions.map {
            (action: $0, style: service.buttonStyle(for: $0, isPressed: false))
        }
    }


    func buttonFontSize(for action: KeyboardAction) -> CGFloat {
        service.buttonFontSize(for: action)
    }

    func buttonFontWeight(for action: KeyboardAction) -> KeyboardFont.FontWeight? {
        service.buttonFontWeight(for: action)
    }


    func testCalloutStyleIsNil() {
        XCTAssertNil(service.calloutStyle)
    }

    func testButtonImageIsStandardForAllActions() {
        KeyboardAction.testActions.forEach {
            let result = service.buttonImage(for: $0)
            let standard = $0.standardButtonImage(for: context)
            result.expectEqual(to: standard)
        }
    }

    func testButtonTextIsStandardForAllActions() {
        KeyboardAction.testActions.forEach {
            let result = service.buttonText(for: $0)
            let standard = $0.standardButtonText(for: context)
            result.expectEqual(to: standard)
        }
    }

    func testButtonStyleBackgroundColorIsStandardForAllExceptPrimaryAction() {
        styles.forEach {
            let result = $0.style.backgroundColor
            let isPrimary = $0.action.isPrimaryAction
            let isSystem = $0.action.isSystemAction
            let expectedBlue = isPrimary && !isSystem
            let expected: Color = expectedBlue ? .blue : service.buttonBackgroundColor(for: $0.action, isPressed: false)
            let equal = result == expected
            let equalOpaque = result == expected.opacity(1.00)
            let equalTransparent = result == expected.opacity(0.95)
            XCTAssertTrue(equal || equalOpaque || equalTransparent)
        }
    }

    func testButtonStyleBorderIsNoStyleForSomeActions() {
        styles.forEach {
            switch $0.action {
            case .none, .emoji:
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
        XCTAssertEqual(buttonFontSize(for: .shift(.lowercased)), 20)
        XCTAssertEqual(buttonFontSize(for: .backspace), 20)
    }

    func testButtonFontSizeIsExplicitlyDefinedForSomeActions() {
        XCTAssertEqual(buttonFontSize(for: .keyboardType(.alphabetic)), 15)
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
        let backspace = service.buttonStyle(for: .backspace, isPressed: false).font
        let character = service.buttonStyle(for: .character(""), isPressed: false).font
        XCTAssertNotEqual(backspace, character)
    }

    func testButtonFontWeightIsLightForActionsWithImageAndLowerCasedChar() {
        XCTAssertNil(buttonFontWeight(for: .character("A")))
        XCTAssertEqual(buttonFontWeight(for: .character("a")), .light)
        XCTAssertEqual(buttonFontWeight(for: .backspace), .regular)
    }

    func testButtonStyleForegroundColorIsStandardForAllActionsExceptPrimaryActions() {
        styles.forEach {
            let standard = $0.action.standardButtonForegroundColor
            let result = $0.style.foregroundColor
            let isPrimary = $0.action.isPrimaryAction
            let isSystem = $0.action.isSystemAction
            let expectedWhite = isPrimary && !isSystem
            let expected: Color = expectedWhite ? .white : standard(context, false)
            XCTAssertEqual(result, expected)
        }
    }

    func testButtonStyleShadowStyleIsNoStyleForSomeActions() {
        styles.forEach {
            switch $0.action {
            case .none, .characterMargin(""), .emoji:
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
