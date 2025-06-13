//
//  KeyboardFont+Standard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-06-13.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardFont {

    /// The standard keyboard font.
    static func standard(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> KeyboardFont {
        let size = standardSize(for: context, action: action)
        let weight = standardWeight(for: context, action: action)
        let font = KeyboardFont.system(size: size)
        if let weight { return font.weight(weight) }
        return font
    }
}

public extension KeyboardFont {

    /// The standard keyboard font size.
    static func standardSize(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> CGFloat {
        if let size = standardSizePad(for: context, action: action) {
            return size
        }
        if action.hasStandardButtonImage(for: context) { return 20 }
        if let fixed = standardSize(for: action) { return fixed }
        let text = action.standardButtonText(for: context) ?? ""
        if action.isPrimaryAction && action.isSystemAction { return 16 }
        if action.isInputAction && text.isLowercasedWithUppercaseVariant { return 26 }
        return 23
    }

    /// The standard keyboard font weight.
    static func standardWeight(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> KeyboardFont.FontWeight? {
        switch action {
        case .backspace: .light
        case .character(let char): char.isLowercasedWithUppercaseVariant ? .light : nil
        default: action.hasStandardButtonImage(for: context) ? .light : nil
        }
    }
}

extension KeyboardFont {

    static func standardSize(
        for action: KeyboardAction
    ) -> CGFloat? {
        switch action {
        case .keyboardType(let type): standardSize(for: type)
        case .space: 16
        case .text: 16
        default: nil
        }
    }

    static func standardSize(
        for type: Keyboard.KeyboardType
    ) -> CGFloat {
        switch type {
        case .alphabetic: 15
        case .numeric: 16
        case .symbolic: 14
        default: 14
        }
    }

    static func standardSizePad(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> CGFloat? {
        if useIpadProText(for: context, action: action) {
            return context.interfaceOrientation == .portrait ? 16 : 20
        }
        guard context.deviceTypeForKeyboard == .pad else { return nil }
        guard context.interfaceOrientation.isLandscape else { return nil }
        if action.isKeyboardTypeAction(.alphabetic) { return 22 }
        if action.isKeyboardTypeAction(.numeric) { return 22 }
        if action.isKeyboardTypeAction(.symbolic) { return 20 }
        return nil
    }

    static func useIpadProText(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Bool {
        switch action {
        case let .keyboardType(type): useIpadProText(for: context, type)
        default: action.standardButtonTextIpadPro(for: context) != nil
        }
    }

    static func useIpadProText(
        for context: KeyboardContext,
        _ type: Keyboard.KeyboardType
    ) -> Bool {
        guard context.deviceTypeForKeyboardIsIpadPro else { return false }
        switch type {
        case .alphabetic, .numeric, .symbolic: return true
        default: return false
        }
    }
}
