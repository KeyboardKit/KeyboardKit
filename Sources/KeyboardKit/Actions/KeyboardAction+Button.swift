//
//  KeyboardAction+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

public extension KeyboardAction {
    
    /// The action's standard button image.
    func standardButtonImage(
        for context: KeyboardContext
    ) -> Image? {
        switch standardButtonText(for: context) {
        case "↵", "↳": .keyboardNewline(for: context.locale)
        default: standardButtonImageRaw(for: context)
        }
    }
    
    /// The action's standard button text.
    func standardButtonText(
        for context: KeyboardContext
    ) -> String? {
        switch self {
        case .character(let char): standardButtonText(for: char)
        case .emoji(let emoji): emoji.char
        case .keyboardType(let type): type.standardButtonText(for: context)
        case .nextLocale: context.locale.languageCode?.uppercased()
        case .primary(let type): type.standardButtonText(for: context.locale)
        case .space: KKL10n.space.text(for: context)
        default: nil
        }
    }
}

private extension KeyboardAction {
    
    func standardButtonImageRaw(
        for context: KeyboardContext
    ) -> Image? {
        switch self {
        case .backspace: .keyboardBackspace(for: context.locale)
        case .capsLock: .keyboardShift(.capsLocked)
        case .command: .keyboardCommand
        case .control: .keyboardControl
        case .dictation: .keyboardDictation
        case .dismissKeyboard: .keyboardDismiss
        case .image(_, let imageName, _): Image(imageName)
        case .keyboardType(let type): type.standardButtonImage
        case .moveCursorBackward: .keyboardArrowLeft
        case .moveCursorForward: .keyboardArrowRight
        case .nextKeyboard: .keyboardGlobe
        case .option: .keyboardOption
        case .primary(let type): type.standardButtonImage(for: context.locale)
        case .settings: .keyboardSettings
        case .shift(let currentCasing): .keyboardShift(currentCasing)
        case .systemImage(_, let imageName, _): Image(systemName: imageName)
        case .systemSettings: .keyboardSettings
        case .tab: .keyboardTab
        default: nil
        }
    }
}

private extension KeyboardAction {
    
    func standardButtonText(for char: String) -> String {
        switch char {
        case .zeroWidthSpace: "⁞"
        default: char
        }
    }
}
