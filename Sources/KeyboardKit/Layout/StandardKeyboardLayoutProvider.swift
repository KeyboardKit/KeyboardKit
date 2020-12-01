//
//  StandardKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

/**
 This keyboard layout provider bases its layout decisions on
 factors like device, screen orientation and locale. It aims
 to create a system keyboard layout for the provided context,
 which is not always what you want.
 
 This provider only supports locales that are also supported
 by the `StandardKeyboardInputSetProvider`, which means that
 non-supported locales will get the standard keyboard layout
 for English keyboards.
 
 This provider will fallback to lowercased alphabetic layout
 if the current context state doesn't have a standard layout.
 One example is if the current keyboard type is `.emojis` or
 another non-standard keyboard. Make sure to check for these
 states your self, and only use this for standard use cases.
 
 If you want to create a custom keyboard extension that does
 not rely on standard system keyboard conventions, you could
 register a custom layout provider or just ignore the entire
 layout provider concept altogether.
 
 You can inherit and customize this class to create your own
 provider that builds on this foundation.
 */
open class StandardKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    public init(
        device: UIDevice = .current,
        locale: Locale = .current,
        inputSetProvider: KeyboardInputSetProvider = StandardKeyboardInputSetProvider()) {
        self.device = device
        self.inputSetProvider = inputSetProvider
        self.locale = locale
    }
    
    init(
        device: UIDevice = .current,
        locale: Locale = .current,
        device
        inputSetProvider: KeyboardInputSetProvider = StandardKeyboardInputSetProvider()) {
        self.device = device
        self.inputSetProvider = inputSetProvider
        self.locale = locale
    }
    
    private let device: UIDevice
    private let inputSetProvider: KeyboardInputSetProvider
    private let locale: Locale
    
    open func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let rows = inputRows(for: context)
        fatalError()
    }
}

private extension StandardKeyboardLayoutProvider {
    
    /**
     This resolves which input set to use for the context in
     question.
     */
    func inputRows(for context: KeyboardContext) -> [KeyboardInputSet.InputRow] {
        switch context.keyboardType {
        case .alphabetic(let state):
            let rows = inputSetProvider.alphabeticInputSet.inputRows
            return state.isUppercased ? rows.uppercased() : rows
        case .numeric: return inputSetProvider.numericInputSet.inputRows
        case .symbolic: return inputSetProvider.symbolicInputSet.inputRows
        default: return inputSetProvider.alphabeticInputSet.inputRows
        }
    }
}
