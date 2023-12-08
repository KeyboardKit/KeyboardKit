//
//  StandardCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
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
open class StandardCalloutActionProvider: CalloutActionProvider {

    /**
     Create a standard callout action provider.

      - Parameters:
        - keyboardContext: The keyboard context to use.
        - baseProvider: The base provider, by default a ``BaseCalloutActionProvider``.
        - localizedProviders: A list of localized layout providers, by default `empty`.
     */
    public init(
        keyboardContext: KeyboardContext,
        baseProvider: CalloutActionProvider = BaseCalloutActionProvider(),
        localizedProviders: [LocalizedProvider] = []
    ) {
        self.keyboardContext = keyboardContext
        self.baseProvider = baseProvider
        let dict = Dictionary(uniqueKeysWithValues: localizedProviders.map { ($0.localeKey, $0) })
        self.localizedProviders = LocaleDictionary(dict)
    }
    
    
    /// This typealias represents a localized provider.
    public typealias LocalizedProvider = CalloutActionProvider & LocalizedService
    

    /// The keyboard context to use.
    public let keyboardContext: KeyboardContext
    
    /// The base provider to use.
    public private(set) var baseProvider: CalloutActionProvider

    /// This is used to resolve the a provider for the context.
    public var localizedProviders: LocaleDictionary<CalloutActionProvider>


    /// Get callout actions for the provided action.
    open func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
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
        localizedProviders.value(for: locale) ?? baseProvider
    }
    
    /// Register a new localized provider.
    open func registerLocalizedProvider(
        _ provider: LocalizedProvider
    ) {
        localizedProviders.set(provider, for: provider.localeKey)
    }
}
