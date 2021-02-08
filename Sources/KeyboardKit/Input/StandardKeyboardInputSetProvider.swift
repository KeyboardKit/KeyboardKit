//
//  StandardKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This standard provider has wrapped localized providers that
 are activated depending on the context locale.
 
 You can provide any number of localized providers in `init`.
 By default, it will use all that exist in this library.
 */
open class StandardKeyboardInputSetProvider: KeyboardInputSetProvider {
    
    public init(
        context: KeyboardContext,
        providers: [LocalizedService & KeyboardInputSetProvider] = [
            EnglishKeyboardInputSetProvider(),
            GermanKeyboardInputSetProvider(),
            ItalianKeyboardInputSetProvider(),
            SwedishKeyboardInputSetProvider()]) {
        self.context = context
        let dict = Dictionary(uniqueKeysWithValues: providers.map { ($0.localeKey, $0) })
        providerDictionary = LocaleDictionary(dict)
    }
    
    private let context: KeyboardContext
    
    public var providerDictionary: LocaleDictionary<KeyboardInputSetProvider>
    
    open func provider(for context: KeyboardContext) -> KeyboardInputSetProvider {
        providerDictionary.value(for: context.locale) ?? EnglishKeyboardInputSetProvider()
    }
    
    open func alphabeticInputSet() -> AlphabeticKeyboardInputSet {
        provider(for: context).alphabeticInputSet()
    }
    
    open func numericInputSet() -> NumericKeyboardInputSet {
        provider(for: context).numericInputSet()
    }
    
    open func symbolicInputSet() -> SymbolicKeyboardInputSet {
        provider(for: context).symbolicInputSet()
    }
}
