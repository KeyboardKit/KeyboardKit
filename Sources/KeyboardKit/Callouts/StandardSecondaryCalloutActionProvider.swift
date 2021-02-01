//
//  StandardSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This provider provides secondary callouts with the standard
 secondary callout actions for the provided action.
 */
open class StandardSecondaryCalloutActionProvider: SecondaryCalloutActionProvider {
    
    public init(context: KeyboardContext) {
        self.context = context
    }
    
    private let context: KeyboardContext
    
    private lazy var providerDictionaryValue: LocaleDictionary<SecondaryCalloutActionProvider> = LocaleDictionary([
        LocaleKey.english.key: EnglishSecondaryCalloutActionProvider(),
        LocaleKey.swedish.key: SwedishSecondaryCalloutActionProvider()
    ])
    
    open var providerDictionary: LocaleDictionary<SecondaryCalloutActionProvider> {
        providerDictionaryValue
    }
    
    open func provider(for context: KeyboardContext) -> SecondaryCalloutActionProvider {
        providerDictionary.value(for: context.locale) ?? EnglishSecondaryCalloutActionProvider()
    }
    
    open func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        provider(for: context).secondaryCalloutActions(for: action)
    }
}
