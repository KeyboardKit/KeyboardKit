//
//  StandardKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

/**
 This keyboard layout provider bases its layout decisions on
 factors like locale, device and screen orientation.
 
 This may not always be what you want. If you want to create
 keyboards with a custom layout, you should either not use a
 layout provider, or create a custom one.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 */
open class StandardKeyboardLayoutProvider: BaseKeyboardLayoutProvider {
    
    private lazy var iPadProvider = iPadKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider,
        dictationReplacement: dictationReplacement)
    
    private lazy var iPhoneProvider = iPhoneKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider,
        dictationReplacement: dictationReplacement)
    
    open override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let isPad = context.device.userInterfaceIdiom == .pad
        return isPad
            ? iPadProvider.keyboardLayout(for: context)
            : iPhoneProvider.keyboardLayout(for: context)
    }
}
