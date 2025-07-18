//
//  KeyboardAction+ButtonText.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

public extension KeyboardAction {

    /// Whether an action has a standard text.
    func hasStandardButtonText(
        for context: KeyboardContext
    ) -> Bool {
        standardButtonText(for: context) != nil
    }

    /// The standard button text.
    func standardButtonText(
        for context: KeyboardContext
    ) -> String? {
        if let text = standardButtonTextIpadPro(for: context) { return text }
        return standardButtonTextBase(for: context)
    }
}

extension KeyboardAction {

    func standardButtonTextBase(
        for context: KeyboardContext
    ) -> String? {
        switch self {
        case .character(let char): standardButtonText(for: char)
        case .diacritic(let dia): dia.char
        case .emoji(let emoji): emoji.char
        case .keyboardType(let type): type.standardButtonText(for: context)
        case .nextLocale: context.locale.languageCode?.uppercased()
        case .primary(let type): type.standardButtonText(for: context.locale)
        case .space: KKL10n.space.text(for: context.locale)
        case .text(let char): standardButtonText(for: char)
        case .urlDomain: "."
        default: nil
        }
    }

    func standardButtonTextIpadPro(
        for context: KeyboardContext
    ) -> String? {
        guard context.isIpadPro && context.isEnglish else { return nil }
        switch self {
        case .tab: return "tab"
        case .capsLock: return "caps lock"
        case .shift: return "shift"
        case .backspace: return "delete"
        case .primary(let type): return type.standardButtonTextIpadPro
        default: return nil
        }
    }
}

private extension Keyboard.ReturnKeyType {

    var standardButtonTextIpadPro: String? {
        switch self {
        case .newLine: "return"
        default: nil
        }
    }
}

private extension KeyboardAction {

    func standardButtonText(
        for char: String
    ) -> String {
        switch char {
        case .zeroWidthSpace: "⁞"
        default: char
        }
    }
}

private extension KeyboardContext {

    var isEnglish: Bool { locale.identifier.hasPrefix("en") }
    var isIpadPro: Bool { self.deviceTypeForKeyboardIsIpadPro }
}
