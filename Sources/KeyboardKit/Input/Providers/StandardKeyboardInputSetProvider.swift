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
 are activated depending on the context's locale.
 
 You can provide any number of localized providers in `init`.
 By default, it will use all providers that exist in the lib.
 */
open class StandardKeyboardInputSetProvider: KeyboardInputSetProvider {
    
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
        providers: [LocalizedKeyboardInputSetProvider] = [EnglishKeyboardInputSetProvider()]) {
        self.context = context
        let dict = Dictionary(uniqueKeysWithValues: providers.map { ($0.localeKey, $0) })
        providerDictionary = LocaleDictionary(dict)
    }
    
    private let context: KeyboardContext
    
    /**
     This is used to resolve the a provider for the context.
     */
    public var providerDictionary: LocaleDictionary<KeyboardInputSetProvider>
    
    /**
     Get the provider to use, given the provided context.
     */
    open func provider(for context: KeyboardContext) -> KeyboardInputSetProvider {
        providerDictionary.value(for: context.locale) ?? EnglishKeyboardInputSetProvider()
    }
    
    /**
     Get the alphabetic input set for the current `context`.
     */
    open var alphabeticInputSet: AlphabeticKeyboardInputSet {
        provider(for: context).alphabeticInputSet
    }
    
    /**
     Get the numeric input set for the current `context`.
     */
    open var numericInputSet: NumericKeyboardInputSet {
        provider(for: context).numericInputSet
    }
    
    /**
     Get the symbolic input set for the current `context`.
     */
    open var symbolicInputSet: SymbolicKeyboardInputSet {
        provider(for: context).symbolicInputSet
    }
}
