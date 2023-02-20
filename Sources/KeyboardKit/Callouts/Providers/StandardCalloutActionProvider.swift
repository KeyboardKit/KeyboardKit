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
 providers, and will use the one with the same locale as the
 provided ``KeyboardContext``.
 */
open class StandardCalloutActionProvider: CalloutActionProvider {

    /**
     Create a standard callout action provider.

      - Parameters:
        - keyboardContext: The keyboard context to use.
        - providers: The action providers to use.
     */
    public init(
        keyboardContext: KeyboardContext,
        providers: [LocalizedCalloutActionProvider] = [standardProvider]
    ) {
        self.keyboardContext = keyboardContext
        let dict = Dictionary(uniqueKeysWithValues: providers.map { ($0.localeKey, $0) })
        localizedProviders = LocaleDictionary(dict)
    }
    
    /**
     Get the standard callout action provider.

     This can be set to change the standard value everywhere.
     */
    public static var standardProvider: LocalizedCalloutActionProvider {
        guard let provider = try? EnglishCalloutActionProvider() else { fatalError("EnglishCalloutActionProvider could not be created.") }
        return provider
    }

    /**
     The keyboard context to use.
     */
    public let keyboardContext: KeyboardContext
    
    /**
     This is used to resolve the a provider for the context.
     */
    public var localizedProviders: LocaleDictionary<CalloutActionProvider>


    /**
     Get callout actions for the provided `action`.
     */
    open func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        provider(for: keyboardContext).calloutActions(for: action)
    }

    /**
     Get the provider to use for the provided `context`.
     */
    open func provider(for context: KeyboardContext) -> CalloutActionProvider {
        provider(for: context.locale)
    }
    
    /**
     Get the provider to use for the provided `locale`.
     */
    open func provider(for locale: Locale) -> CalloutActionProvider {
        localizedProviders.value(for: locale) ?? Self.standardProvider
    }
}
