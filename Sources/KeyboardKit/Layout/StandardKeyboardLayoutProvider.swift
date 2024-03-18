//
//  StandardKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This provider is initialized with a collection of localized
 providers, as well as a base provider.
 
 If the localized providers doesn't contain a provider for a
 certain locale, the base provider will be used.
 
 The standard configuration is to use a base provider and no
 localized providers. KeyboardKit Pro will inject a provider
 for each locale in your license when you register a license.
 
 KeyboardKit automatically creates an instance of this class
 and binds it to ``KeyboardInputViewController/services``.
 */
open class StandardKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    /**
     Create a standard keyboard layout provider.
     
     - Parameters:
       - baseProvider: The base provider, by default a ``InputSetBasedKeyboardLayoutProvider``.
       - localizedProviders: A list of localized layout providers, by default `empty`.
     */
    public init(
        baseProvider: KeyboardLayoutProvider = InputSetBasedKeyboardLayoutProvider(),
        localizedProviders: [LocalizedProvider] = []
    ) {
        self.baseProvider = baseProvider
        let dict = Dictionary(uniqueKeysWithValues: localizedProviders.map { ($0.localeKey, $0) })
        self.localizedProviders = LocaleDictionary(dict)
    }

    
    /// This typealias represents a localized provider.
    public typealias LocalizedProvider = KeyboardLayoutProvider & LocalizedService
    
    
    /// The base provider to use.
    public private(set) var baseProvider: KeyboardLayoutProvider

    /// A dictionary with localized layout providers.
    public var localizedProviders: LocaleDictionary<KeyboardLayoutProvider>


    /// The keyboard layout to use for a certain context.
    open func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        keyboardLayoutProvider(for: context)
            .keyboardLayout(for: context)
    }

    /// The layout provider to use for a given context.
    open func keyboardLayoutProvider(for context: KeyboardContext) -> KeyboardLayoutProvider {
        let localized = localizedProviders.value(for: context.locale)
        return localized ?? baseProvider
    }
    
    /// Register a new localized provider.
    open func registerLocalizedProvider(
        _ provider: LocalizedProvider
    ) {
        localizedProviders.set(provider, for: provider.localeKey)
    }
}
