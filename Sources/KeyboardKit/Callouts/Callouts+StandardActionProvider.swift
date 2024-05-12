//
//  Callouts+StandardActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension Callouts {
    
    /// This class provides a standard way to handle callout
    /// actions, that can be presented by the keyboard.
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
    /// See <doc:Callouts-Article> for more information.
    open class StandardActionProvider: CalloutActionProvider {
        
        /// Create a standard callout action provider.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - baseProvider: The base provider, by default a ``Callouts/BaseActionProvider``.
        ///   - localizedProviders: A list of localized layout providers, by default `empty`.
        public init(
            keyboardContext: KeyboardContext,
            baseProvider: CalloutActionProvider = Callouts.BaseActionProvider(),
            localizedProviders: [LocalizedProvider] = []
        ) {
            self.keyboardContext = keyboardContext
            self.baseProvider = baseProvider
            let dict = Dictionary(uniqueKeysWithValues: localizedProviders.map { ($0.localeKey, $0) })
            self.localizedProviders = .init(dict)
        }
        
        
        /// This typealias represents a localized provider.
        public typealias LocalizedProvider = CalloutActionProvider & LocalizedService
        
        
        /// The keyboard context to use.
        public let keyboardContext: KeyboardContext
        
        /// The base provider to use.
        public private(set) var baseProvider: CalloutActionProvider
        
        /// This is used to resolve the a provider for the context.
        public var localizedProviders: KeyboardLocale.Dictionary<CalloutActionProvider>
        
        /// This is an optional resolver that is used by Pro to lazily resolve providers.
        public var localizedProviderResolver: ((Locale) -> CalloutActionProvider?)? = nil
        
        
        /// Get callout actions for the provided action.
        open func calloutActions(
            for action: KeyboardAction
        ) -> [KeyboardAction] {
            calloutActionProvider(for: keyboardContext)
                .calloutActions(for: action)
        }
        
        /// Get the provider to use for the provided context.
        open func calloutActionProvider(
            for context: KeyboardContext
        ) -> CalloutActionProvider {
            calloutActionProvider(for: context.locale)
        }
        
        /// Get the provider to use for the provided locale.
        open func calloutActionProvider(
            for locale: Locale
        ) -> CalloutActionProvider {
            if let provider = localizedProviders.value(for: locale) { return provider }
            if let provider = localizedProviderResolver?(locale) {
                localizedProviders.dictionary[locale.identifier] = provider
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
