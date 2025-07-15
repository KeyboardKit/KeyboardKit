//
//  KeyboardAction+ButtonFont.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-06-13.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardAction {

    /// The standard keyboard font.
    func standardButtonFont(
        for context: KeyboardContext
    ) -> KeyboardFont {
        let size = standardButtonFontSize(for: context)
        let weight = standardButtonFontWeight(for: context)
        let font = KeyboardFont.system(size: size)
        if let weight { return font.weight(weight) }
        return font
    }
}

public extension KeyboardAction {

    /// The standard keyboard font size.
    func standardButtonFontSize(
        for context: KeyboardContext
    ) -> CGFloat {
        if let size = standardButtonFontSizePad(for: context) { return size }
        if hasStandardButtonImage(for: context) { return 20 }
        if let fixed = standardButtonFontSizeFixed() { return fixed }
        let text = standardButtonText(for: context) ?? ""
        if isPrimaryAction { return 16 }
        if isInputAction && text.isLowercasedWithUppercaseVariant { return 26 }
        return 23
    }

    /// The standard keyboard font weight.
    func standardButtonFontWeight(
        for context: KeyboardContext
    ) -> KeyboardFont.FontWeight? {
        switch self {
        case .backspace: .light
        case .character(let char): char.isLowercasedWithUppercaseVariant ? .light : nil
        default: hasStandardButtonImage(for: context) ? .light : nil
        }
    }
}

extension Keyboard.KeyboardType {

    var standardButtonFontSize: CGFloat {
        switch self {
        case .alphabetic: 15
        case .numeric: 16
        case .symbolic: 14
        default: 14
        }
    }
}

extension KeyboardAction {

    func standardButtonFontSizeFixed() -> CGFloat? {
        switch self {
        case .keyboardType(let type): type.standardButtonFontSize
        case .space: 16
        case .text: 16
        default: nil
        }
    }

    func standardButtonFontSizePad(
        for context: KeyboardContext
    ) -> CGFloat? {
        if useIpadProText(for: context) {
            return context.interfaceOrientation == .portrait ? 16 : 20
        }
        guard context.deviceTypeForKeyboard == .pad else { return nil }
        guard context.interfaceOrientation.isLandscape else { return nil }
        if isKeyboardTypeAction(.alphabetic) { return 22 }
        if isKeyboardTypeAction(.numeric) { return 22 }
        if isKeyboardTypeAction(.symbolic) { return 20 }
        return nil
    }

    func useIpadProText(
        for context: KeyboardContext
    ) -> Bool {
        switch self {
        case let .keyboardType(type): useIpadProText(for: context, type)
        default: standardButtonTextIpadPro(for: context) != nil
        }
    }

    func useIpadProText(
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
