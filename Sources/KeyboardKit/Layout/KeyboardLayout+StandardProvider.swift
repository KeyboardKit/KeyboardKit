//
//  KeyboardLayout+StandardProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension KeyboardLayout {
    
    /// This class provides a standard way to create dynamic
    /// keyboard layouts.
    ///
    /// The class can register ``localizedProviders``, which
    /// will then be used to resolve actions for the locales
    /// they specify. If a ``KeyboardLocale`` is not handled
    /// by these locales the ``baseProvider`` is used.
    ///
    /// KeyboardKit automatically creates an instance of the
    /// class when the keyboard is launched, then injects it
    /// into ``KeyboardInputViewController/services``.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// See <doc:Layout-Article> for more information.
    open class StandardProvider: KeyboardLayoutProvider {
        
        /// Create a standard keyboard layout provider.
        ///
        /// - Parameters:
        ///   - baseProvider: The base provider, by default a ``KeyboardLayout/DeviceBasedProvider``.
        ///   - localizedProviders: A list of localized layout providers, by default `empty`.
        public init(
            baseProvider: KeyboardLayoutProvider = KeyboardLayout.DeviceBasedProvider(),
            localizedProviders: [LocalizedProvider] = []
        ) {
            self.baseProvider = baseProvider
            let dict = Dictionary(uniqueKeysWithValues: localizedProviders.map { ($0.localeKey, $0) })
            self.localizedProviders = .init(dict)
        }
        
        
        /// This typealias represents a localized provider.
        public typealias LocalizedProvider = KeyboardLayoutProvider & LocalizedService
        
        
        /// The base provider to use.
        public private(set) var baseProvider: KeyboardLayoutProvider
        
        /// A dictionary with localized layout providers.
        public var localizedProviders: KeyboardLocale.Dictionary<KeyboardLayoutProvider>
        
        /// This is an optional resolver that is used by Pro to lazily resolve providers.
        public static var localizedProviderResolver: ((KeyboardLocale) -> KeyboardLayoutProvider?)? = nil
        
        
        /// The keyboard layout to use for a certain context.
        open func keyboardLayout(
            for context: KeyboardContext
        ) -> KeyboardLayout {
            keyboardLayoutProvider(for: context)
                .keyboardLayout(for: context)
        }
        
        /// The layout provider to use for a given context.
        open func keyboardLayoutProvider(
            for context: KeyboardContext
        ) -> KeyboardLayoutProvider {
            let locale = context.keyboardLocale ?? .english
            if let provider = localizedProviders.value(for: locale) { return provider }
            if let provider = Self.localizedProviderResolver?(locale) {
                localizedProviders.dictionary[locale.localeIdentifier] = provider
                return provider
            }
            return baseProvider
        }
        
        /// Register a new localized provider.
        open func registerLocalizedProvider(
            _ provider: LocalizedProvider
        ) {
            localizedProviders.set(provider, for: provider.localeKey)
        }
    }
}
