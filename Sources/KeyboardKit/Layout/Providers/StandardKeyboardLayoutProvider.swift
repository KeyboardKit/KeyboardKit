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
 the type of device used. It will toggle between an `iPhone`
 and `iPad` specific layout provider.
 
 To change the layouts provided by the class, you can either
 replace `iPadProvider` and `iPhoneProvider` with completely
 new providers. You can also inherit this class and override
 `keyboardLayout(for:)` to return anything you like.
 */
open class StandardKeyboardLayoutProvider: BaseKeyboardLayoutProvider {
    
    public lazy var iPadProvider = iPadKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider,
        dictationReplacement: dictationReplacement)
    
    public lazy var iPhoneProvider = iPhoneKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider,
        dictationReplacement: dictationReplacement)
    
    /**
     Get a keyboard layout for the provided context.
     */
    open override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let isPad = context.device.userInterfaceIdiom == .pad
        return isPad
            ? iPadProvider.keyboardLayout(for: context)
            : iPhoneProvider.keyboardLayout(for: context)
    }
    
    /**
     Register a new input set provider. This will be proxied
     down to the child providers.
     */
    open override func register(inputSetProvider: KeyboardInputSetProvider) {
        self.inputSetProvider = inputSetProvider
        iPadProvider.register(inputSetProvider: inputSetProvider)
        iPhoneProvider.register(inputSetProvider: inputSetProvider)
    }
}
