//
//  StandardKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This provider is initialized with a collection of localized
 providers, and will use the one with the same locale as the
 provided ``KeyboardContext``.

 Since this locale-based approach is still being implemented,
 the provider still has a fallback that uses an `iPhone` and
 an `iPad` specific layout provider that handles the layouts
 for all non-implemented locales.
 
 To modify the layout that is returned by this provider, you
 can inject a new, custom provider for a certain locale. You
 can also inherit the class and override any part of it that
 you want to customize.
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
        localizedProviders: [LocalizedKeyboardLayoutProvider] = [EnglishKeyboardLayoutProvider()]
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
