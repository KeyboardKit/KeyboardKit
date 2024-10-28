//
//  KeyboardStyle+StandardService+iPad.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension KeyboardStyle.StandardService {
    
    var useSmallTextForControlButtons: Bool {
        return
            keyboardContext.deviceType == .pad &&
            keyboardContext.locale.identifier.hasPrefix("en") &&
            iPadProRenderingModeActive
    }
    
    func buttonColorPadProOverride(for action: KeyboardAction) -> Color? {
        let isCapsLock = keyboardContext.keyboardCase == .capsLocked
        switch action {
        case .capsLock: return isCapsLock ? buttonBackgroundColor(for: .backspace, isPressed: true) : nil
        case .shift: return isCapsLock ? buttonBackgroundColor(for: .backspace, isPressed: false) : nil
        default: return nil
        }
    }
    
    func buttonFontSizePadOverride(for action: KeyboardAction) -> CGFloat? {
        if useSmallText(for: action) {
            return keyboardContext.interfaceOrientation == .portrait ? 16 : 20
        }
        guard keyboardContext.deviceType == .pad else { return nil }
        let isLandscape = keyboardContext.interfaceOrientation.isLandscape
        guard isLandscape else { return nil }
        if action.isAlphabeticKeyboardTypeAction { return 22 }
        if action.isKeyboardTypeAction(.numeric) { return 22 }
        if action.isKeyboardTypeAction(.symbolic) { return 20 }
        return nil
    }
    
    func buttonImagePadOverride(for action: KeyboardAction) -> Image? {
        guard iPadProRenderingModeActive else { return nil }
        let isCapsLock = keyboardContext.keyboardCase == .capsLocked
        switch action {
        case .capsLock: return isCapsLock ? .keyboardShiftCapslocked : .keyboardShiftCapslockInactive
        case .shift: return isCapsLock ? .keyboardShiftLowercased : nil
        default: return nil
        }
    }
    
    func buttonTextPadOverride(for action: KeyboardAction) -> String? {
        guard useSmallText(for: action) else { return nil }
        switch action {
        case .tab: return "tab"
        case .capsLock: return "caps lock"
        case .shift: return "shift"
        case .backspace: return "delete"
        case .primary(let type): return type.buttonTextPadOverride
        default: return nil
        }
    }
    
    func useSmallText(for action: KeyboardAction) -> Bool {
        guard useSmallTextForControlButtons else { return false }
        switch action {
        case .tab, .capsLock, .shift, .backspace, .primary: return true
        case .keyboardType(let type): return useSmallText(for: type)
        default: return false
        }
    }
    
    func useSmallText(for type: Keyboard.KeyboardType) -> Bool {
        guard useSmallTextForControlButtons else { return false }
        switch type {
        case .alphabetic, .numeric, .symbolic: return true
        default: return false
        }
    }
}

private extension Keyboard.ReturnKeyType {
    
    var buttonTextPadOverride: String? {
        switch self {
        case .newLine: "return"
        default: standardButtonText(for: .english)
        }
    }
}
