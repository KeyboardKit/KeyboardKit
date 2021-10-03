//
//  StandardKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This keyboard layout provider bases its layout decisions on
 the type of device used. It will toggle between an `iPhone`
 and `iPad` specific layout provider.
 
 Note that since this class depends on an input set provider,
 you must register a new provider whenever it changes. It is
 taken care of by the keyboard input view controller `didSet`
 for its input set provider.
 
 To change the layouts provided by the class, you can either
 replace `iPadProvider` and `iPhoneProvider` with completely
 new providers. You can also inherit this class and override
 `keyboardLayout(for:)` to return anything you like.
 */
open class StandardKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    /**
     Create a standard keyboard layout provider.
     
     - Parameters:
       - inputSetProvider: The input set provider to use.
       - dictationReplacement: An optional dictation replacement action.
     */
    public init(
        inputSetProvider: KeyboardInputSetProvider,
        dictationReplacement: KeyboardAction? = nil) {
        self.inputSetProvider = inputSetProvider
        self.dictationReplacement = dictationReplacement
    }
    
    
    /**
     An optional dictation replacement action.
     */
    public let dictationReplacement: KeyboardAction?
    
    /**
     The input set provider to use.
     */
    public var inputSetProvider: KeyboardInputSetProvider {
        didSet {
            iPadProvider.register(inputSetProvider: inputSetProvider)
            iPhoneProvider.register(inputSetProvider: inputSetProvider)
        }
    }
    
    
    /**
     The layout provider that is used for iPad devices.
     */
    open lazy var iPadProvider = iPadKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider,
        dictationReplacement: dictationReplacement)
    
    /**
     The layout provider that is used for iPhone devices.
     */
    open lazy var iPhoneProvider = iPhoneKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider,
        dictationReplacement: dictationReplacement)
    
    
    /**
     Get a keyboard layout for a certain keyboard `context`.
     */
    open func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        layoutProvider(for: context).keyboardLayout(for: context)
    }
    
    /**
     Get a keyboard layout provider for a certain `context`.
     */
    open func layoutProvider(for context: KeyboardContext) -> SystemKeyboardLayoutProvider {
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
