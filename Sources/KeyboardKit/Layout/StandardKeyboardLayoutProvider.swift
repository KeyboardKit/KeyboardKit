//
//  StandardKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This standard keyboard layout provider uses a collection of
 localized providers as well as a base one, to resolve which
 provider use for a certain keyboard context.
 
 If the localized providers doesn't contain a provider for a
 certain locale, then the base provider will be used.
 
 The default configuration is to use a standard English base
 provider and no localized providers. To modify the keyboard
 layout for a certain locale, just provide a layout provider
 for that specific locale.
 */
open class StandardKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    /**
     Create a standard keyboard layout provider.
     
     - Parameters:
       - baseProvider: The provider to use when no localized provider matches the context, by default ``InputSetBasedKeyboardLayoutProvider``.
       - localizedProviders: A dictionary with localized layout providers, by default `empty`.
     */
    public init(
        baseProvider: KeyboardLayoutProvider = InputSetBasedKeyboardLayoutProvider(),
        localizedProviders: [KeyboardLayoutProvider & LocalizedService] = []
    ) {
        self.baseProvider = baseProvider
        let dict = Dictionary(uniqueKeysWithValues: localizedProviders.map { ($0.localeKey, $0) })
        self.localizedProviders = LocaleDictionary(dict)
    }

    
    /// The base provider to use.
    public private(set) var baseProvider: KeyboardLayoutProvider

    /// A dictionary with localized layout providers.
    public let localizedProviders: LocaleDictionary<KeyboardLayoutProvider>


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
}
