//
//  StandardKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This input set provider provides the standard input set for
 the locale of the current context.
 
 You can inherit and customize this class to create your own
 provider that builds on this foundation.
 */
open class StandardKeyboardInputSetProvider: KeyboardInputSetProvider {
    
    public init() {}
    
    open func alphabeticInputSet(for context: KeyboardContext) -> AlphabeticKeyboardInputSet {
        provider(for: context).alphabeticInputSet(for: context)
    }
    
    open func numericInputSet(for context: KeyboardContext) -> NumericKeyboardInputSet {
        provider(for: context).numericInputSet(for: context)
    }
    
    open func symbolicInputSet(for context: KeyboardContext) -> SymbolicKeyboardInputSet {
        provider(for: context).symbolicInputSet(for: context)
    }
    
    open var providerTable: [String: KeyboardInputSetProvider] {
        [
            "de": GermanKeyboardInputSetProvider(),
            "en": EnglishKeyboardInputSetProvider(),
            "it": ItalianKeyboardInputSetProvider(),
            "sv": SwedishKeyboardInputSetProvider()
        ]
    }
    
    open func provider(for context: KeyboardContext) -> KeyboardInputSetProvider {
        let locale = context.locale
        if let provider = providerTable[locale.identifier] { return provider }
        if let provider = providerTable[locale.languageCode ?? ""] { return provider }
        return EnglishKeyboardInputSetProvider()
    }
}
