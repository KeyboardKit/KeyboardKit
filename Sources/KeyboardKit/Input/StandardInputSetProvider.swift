//
//  StandardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This provider is initialized with a collection of localized
 providers, and will use the one with the same locale as the
 provided ``KeyboardContext``.
 */
open class StandardInputSetProvider: InputSetProvider {
    
    /**
     Create a standard provider.
     
      - Parameters:
        - keyboardContext: The keyboard context to use.
        - localizedProviders: The localized providers to use, by default only `English`.
     */
    public init(
        keyboardContext: KeyboardContext,
        localizedProviders: [LocalizedInputSetProvider] = [EnglishInputSetProvider()]
    ) {
        self.keyboardContext = keyboardContext
        let dict = Dictionary(uniqueKeysWithValues: localizedProviders.map { ($0.localeKey, $0) })
        self.localizedProviders = LocaleDictionary(dict)
    }


    /**
     The keyboard context to use.
     */
    public let keyboardContext: KeyboardContext

    /**
     A dictionary with ``InputSetProvider`` instances.
     */
    public let localizedProviders: LocaleDictionary<InputSetProvider>


    /**
     The provider to use for a certain keyboard context.
     */
    open func provider(for context: KeyboardContext) -> InputSetProvider {
        localizedProviders.value(for: context.locale) ?? EnglishInputSetProvider()
    }
    
    /**
     The input set to use for alphabetic keyboards.
     */
    open var alphabeticInputSet: AlphabeticInputSet {
        provider(for: keyboardContext).alphabeticInputSet
    }
    
    /**
     The input set to use for numeric keyboards.
     */
    open var numericInputSet: NumericInputSet {
        provider(for: keyboardContext).numericInputSet
    }
    
    /**
     The input set to use for symbolic keyboards.
     */
    open var symbolicInputSet: SymbolicInputSet {
        provider(for: keyboardContext).symbolicInputSet
    }
}
