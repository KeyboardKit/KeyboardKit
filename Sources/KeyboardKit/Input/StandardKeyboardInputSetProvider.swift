//
//  StandardKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This provider is used by default, and provides the standard
 input set for the current locale, if any.
 
 You can inherit and customize this class to create your own
 provider that builds on this foundation. 
 
 The dictionaries contain the currently supported input sets.
 They are not part of the protocol, but you can use them and
 extend them in your own subclasses.
 */
open class StandardKeyboardInputSetProvider: KeyboardInputSetProvider {
    
    public init() {}
    
    open func alphabeticInputSet(for context: KeyboardContext) -> AlphabeticKeyboardInputSet {
        getInputSet(for: context, in: alphabeticTable, fallback: .alphabetic_en)
    }
    
    open var alphabeticTable: [String: AlphabeticKeyboardInputSet] {
        [
            "de": .alphabetic_de,
            "en": .alphabetic_en,
            "it": .alphabetic_it,
            "sv": .alphabetic_sv
        ]
    }
    
    open func numericInputSet(for context: KeyboardContext) -> NumericKeyboardInputSet {
        getInputSet(for: context, in: numericTable, fallback: .numeric_en)
    }
    
    open var numericTable: [String: NumericKeyboardInputSet] {
        [
            "de": .numeric_de,
            "en": .numeric_en,
            "it": .numeric_it,
            "sv": .numeric_sv
        ]
    }
    
    open func symbolicInputSet(for context: KeyboardContext) -> SymbolicKeyboardInputSet {
        getInputSet(for: context, in: symbolicTable, fallback: .symbolic_en)
    }
    
    open var symbolicTable: [String: SymbolicKeyboardInputSet] {
        [
            "de": .symbolic_de,
            "en": .symbolic_en,
            "it": .symbolic_it,
            "sv": .symbolic_sv
        ]
    }
    
    open func getInputSet<Type: KeyboardInputSet>(for context: KeyboardContext, in table: [String: Type], fallback: Type) -> Type {
        let locale = context.locale
        if let set = table[locale.identifier] { return set }
        if let set = table[locale.languageCode ?? "en"] { return set }
        return fallback
    }
}
