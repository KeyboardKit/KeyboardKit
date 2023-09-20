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
 providers, and will try to use one that matches the context.
 */
open class StandardCalloutActionProvider: CalloutActionProvider {

    /**
     Create a standard callout action provider.

      - Parameters:
        - keyboardContext: The keyboard context to use.
        - providers: The action providers to use, by default `empty`.
     */
    public init(
        keyboardContext: KeyboardContext,
        localizedProviders: [CalloutActionProvider & LocalizedService] = []
    ) {
        self.keyboardContext = keyboardContext
        let dict = Dictionary(uniqueKeysWithValues: localizedProviders.map { ($0.localeKey, $0) })
        self.localizedProviders = LocaleDictionary(dict)
    }

    /// The keyboard context to use.
    public let keyboardContext: KeyboardContext
    
    /// This is used to resolve the a provider for the context.
    public var localizedProviders: LocaleDictionary<CalloutActionProvider>


    /// Get callout actions for the provided action.
    open func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        let provider = provider(for: keyboardContext)
        let actions = provider?.calloutActions(for: action)
        return actions ?? []
    }

    /// Get the provider to use for the provided context.
    open func provider(for context: KeyboardContext) -> CalloutActionProvider? {
        provider(for: context.locale)
    }
    
    /// Get the provider to use for the provided locale.
    open func provider(for locale: Locale) -> CalloutActionProvider? {
        localizedProviders.value(for: locale)
    }
}
