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
    
    public init(
        context: KeyboardContext,
        providers: [LocalizedSecondaryCalloutActionProvider] = [EnglishSecondaryCalloutActionProvider()]) {
        self.context = context
        let dict = Dictionary(uniqueKeysWithValues: providers.map { ($0.localeKey, $0) })
        providerDictionary = LocaleDictionary(dict)
    }
    
    private let context: KeyboardContext
    
    public var providerDictionary: LocaleDictionary<SecondaryCalloutActionProvider>
    
    open func provider(for context: KeyboardContext) -> SecondaryCalloutActionProvider {
        providerDictionary.value(for: context.locale) ?? EnglishSecondaryCalloutActionProvider()
    }
    
    open func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        provider(for: context).secondaryCalloutActions(for: action)
    }
}
