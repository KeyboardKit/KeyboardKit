//
//  StandardCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This standard callout action provider takes a collection of
 localized `providers` then uses a locale to determine which
 one to use.
 */
open class StandardCalloutActionProvider: CalloutActionProvider {
    
    /**
     Create a standard provider.
     
     Injecting a context and not a locale keeps the provider
     dynamic when the context changes language.
     
      - Parameters:
        - context: The keyboard context to use.
        - providers: The action providers to use.
     */
    public init(
        context: KeyboardContext,
        providers: [LocalizedCalloutActionProvider] = [standardProvider]
    ) {
        self.context = context
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
    
    private let context: KeyboardContext
    
    /**
     This is used to resolve the a provider for the context.
     */
    public var localizedProviders: LocaleDictionary<CalloutActionProvider>
    
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
    
    /**
     Get callout actions for the provided `action`.
     */
    open func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        provider(for: context).calloutActions(for: action)
    }


    // MARK: - Deprecated

    @available(*, deprecated, renamed: "localizedProviders")
    open var providerDictionary: LocaleDictionary<CalloutActionProvider> {
        localizedProviders
    }
}
