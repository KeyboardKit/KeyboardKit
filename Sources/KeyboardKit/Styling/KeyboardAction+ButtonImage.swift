//
//  KeyboardAction+ButtonImage.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

public extension KeyboardAction {

    /// Whether an action has a standard image.
    func hasStandardButtonImage(
        for context: KeyboardContext
    ) -> Bool {
        standardButtonImage(for: context) != nil
    }

    /// The standard button image.
    func standardButtonImage(
        for context: KeyboardContext
    ) -> Image? {
        guard standardButtonTextIpadPro(for: context) == nil else { return nil }
        if let caps = buttonImageCaps(for: context) { return caps }
        switch standardButtonText(for: context) {
        case "↵", "↳": return .keyboardNewline(for: context.locale)
        default: return buttonImageBase(for: context)
        }
    }

    /// The standard button image scale.
    func standardButtonImageScale(
        for context: KeyboardContext
    ) -> CGFloat {
        switch context.deviceTypeForKeyboard {
        case .pad: 1.2
        default: 1
        }
    }
}

extension KeyboardAction {

    func buttonImageBase(
        for context: KeyboardContext
    ) -> Image? {
        switch self {
        case .backspace: .keyboardBackspace(for: context.locale)
        case .capsLock: .keyboardShiftCapslockInactive
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
        case .shift: .keyboardShift(context.keyboardCase)
        case .systemImage(_, let imageName, _): Image(systemName: imageName)
        case .systemSettings: .keyboardSettings
        case .tab: .keyboardTab
        case .url: .keyboardUrl
        default: nil
        }
    }

    func buttonImageCaps(
        for context: KeyboardContext
    ) -> Image? {
        guard context.keyboardCase == .capsLocked else { return nil }
        switch self {
        case .capsLock: return .keyboardShiftCapslockActive
        case .shift: return context.isIpadPro ? .keyboardShiftLowercased : .keyboardShiftCapslockActive
        default: return nil
        }
    }
}

private extension KeyboardContext {

    var isIpadPro: Bool { deviceTypeForKeyboardIsIpadPro }
}
