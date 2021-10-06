//
//  StandardSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This standard provider takes many localized `providers` and
 use the locale of the provided `context` to determine which
 one to use.
 */
open class StandardSecondaryCalloutActionProvider: SecondaryCalloutActionProvider {
    
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
        providers: [LocalizedSecondaryCalloutActionProvider] = [standardProvider]) {
        self.context = context
        let dict = Dictionary(uniqueKeysWithValues: providers.map { ($0.localeKey, $0) })
        providerDictionary = LocaleDictionary(dict)
    }
    
    /**
     Get the standard action provider, which is used when no
     custom providers are provided.
     */
    public static var standardProvider: LocalizedSecondaryCalloutActionProvider {
        guard let provider = try? EnglishSecondaryCalloutActionProvider() else { fatalError("EnglishSecondaryCalloutActionProvider could not be created.") }
        return provider
    }
    
    private let context: KeyboardContext
    
    /**
     This is used to resolve the a provider for the context.
     */
    public var providerDictionary: LocaleDictionary<SecondaryCalloutActionProvider>
    
    /**
     Get the provider to use, given the provided context.
     */
    open func provider(for context: KeyboardContext) -> SecondaryCalloutActionProvider {
        providerDictionary.value(for: context.locale) ?? Self.standardProvider
    }
    
    /**
     Get secondary callout actions for the provided `action`.
     */
    open func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        provider(for: context).secondaryCalloutActions(for: action)
    }
}
