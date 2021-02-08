//
//  StandardSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This standard provider has wrapped localized providers that
 are activated depending on the context locale.
 
 You can provide any number of localized providers in `init`.
 By default, it will use all that exist in this library.
 */
open class StandardSecondaryCalloutActionProvider: SecondaryCalloutActionProvider {
    
    public init(
        context: KeyboardContext,
        providers: [LocalizedService & SecondaryCalloutActionProvider] = [
            EnglishSecondaryCalloutActionProvider(),
            SwedishSecondaryCalloutActionProvider()]) {
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
