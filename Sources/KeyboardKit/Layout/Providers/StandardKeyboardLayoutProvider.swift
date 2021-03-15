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
open class StandardKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    public init(
        inputSetProvider: KeyboardInputSetProvider,
        dictationReplacement: KeyboardAction? = nil) {
        self.inputSetProvider = inputSetProvider
        self.dictationReplacement = dictationReplacement
    }

    public let dictationReplacement: KeyboardAction?
    
    public var inputSetProvider: KeyboardInputSetProvider {
        didSet {
            iPadProvider.register(inputSetProvider: inputSetProvider)
            iPhoneProvider.register(inputSetProvider: inputSetProvider)
        }
    }
    
    /**
     The provider that will be used for iPad devices.
     */
    open lazy var iPadProvider = iPadKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider,
        dictationReplacement: dictationReplacement)
    
    /**
     The provider that will be used for iPhone devices.
     */
    open lazy var iPhoneProvider = iPhoneKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider,
        dictationReplacement: dictationReplacement)
    
    /**
     Get a keyboard layout for the provided context.
     */
    open func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        layoutProvider(for: context).keyboardLayout(for: context)
    }
    
    /**
     Get a keyboard layout provider for the provided context.
     */
    open func layoutProvider(for context: KeyboardContext) -> BaseKeyboardLayoutProvider {
        context.device.isPad ? iPadProvider : iPhoneProvider
    }
    
    /**
     Register a new input set provider. This will be proxied
     down to the child providers.
     */
    open func register(inputSetProvider: KeyboardInputSetProvider) {
        self.inputSetProvider = inputSetProvider
    }
}
