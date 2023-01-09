//
//  StandardKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This layout provider is initialized with a keyboard context,
 an input set provider and a list of localized providers.

 If the keyboard context locale matches a localized provider,
 that provider will be used instead of the input set and the
 standard iPhone and iPad providers that are created by this
 class. This will cause the input set provider to be ignored,
 since the matching provider will have its own input set.

 Since English is the standard input set and keyboard layout
 configuration, this provider has no English provider in its
 list of localized providers, since it would cause the input
 set provider to always be ignored.
 
 To modify the layout that is returned by this provider, you
 can inject new providers for a more locales.
 */
open class StandardKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    /**
     Create a standard keyboard layout provider.
     
     - Parameters:
       - keyboardContext: The keyboard context to use.
       - inputSetProvider: The input set provider to use.
       - layoutProviders: The localized providers to use, by default only English.
     */
    public init(
        keyboardContext: KeyboardContext,
        inputSetProvider: InputSetProvider,
        localizedProviders: [LocalizedKeyboardLayoutProvider] = []
    ) {
        self.keyboardContext = keyboardContext
        self.inputSetProvider = inputSetProvider
        let dict = Dictionary(uniqueKeysWithValues: localizedProviders.map { ($0.localeKey, $0) })
        self.localizedProviders = LocaleDictionary(dict)
    }

    /**
     The input set provider to use.

     > Important: This is deprecated and will be removed in KeyboardKit 7.0
     */
    public var inputSetProvider: InputSetProvider {
        didSet {
            iPadProvider.register(inputSetProvider: inputSetProvider)
            iPhoneProvider.register(inputSetProvider: inputSetProvider)
        }
    }

    /**
     The keyboard context to use.
     */
    public let keyboardContext: KeyboardContext

    /**
     A dictionary with ``KeyboardLayoutProvider`` instances.
     */
    public let localizedProviders: LocaleDictionary<KeyboardLayoutProvider>


    /**
     The keyboard layout provider to use for iPad devices.

     > Important: This is deprecated and will be removed in KeyboardKit 7.0
     */
    open lazy var iPadProvider = iPadKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider)

    /**
     The keyboard layout provider to use for iPhone devices.

     > Important: This is deprecated and will be removed in KeyboardKit 7.0
     */
    open lazy var iPhoneProvider = iPhoneKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider)

    /**
     The keyboard layout to use for a certain context.
     */
    open func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        keyboardLayoutProvider(for: context)
            .keyboardLayout(for: context)
    }

    /**
     The keyboard layout provider to use for a given context.
     */
    open func keyboardLayoutProvider(for context: KeyboardContext) -> KeyboardLayoutProvider {
        if let provider = localizedProviders.value(for: context.locale) { return provider }
        return context.deviceType == .pad ? iPadProvider : iPhoneProvider
    }

    /**
     Register a new input set provider.
     */
    open func register(inputSetProvider: InputSetProvider) {
        self.inputSetProvider = inputSetProvider
    }



    // MARK: - Deprecated

    @available(*, deprecated, message: "This is no longer used and will be removed in KeyboardKit 7.")
    open lazy var fallbackProvider = StaticKeyboardLayoutProvider(
        keyboardLayout: KeyboardLayout(itemRows: []))

    @available(*, deprecated, renamed: "keyboardLayoutProvider(for:)")
    open func layoutProvider(for context: KeyboardContext) -> KeyboardLayoutProvider {
        keyboardLayoutProvider(for: context)
    }
}
