//
//  StandardKeyboardInputProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
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
open class StandardKeyboardInputProvider: KeyboardInputProvider {
    
    public init(locale: Locale = .current) {
        self.locale = locale
    }
    

    private let locale: Locale
    
    
    open var alphabeticInputSet: AlphabeticKeyboardInputSet {
        getInputSet(in: alphabeticTable, fallback: .alphabetic_en)
    }
    
    open var alphabeticTable: [String: AlphabeticKeyboardInputSet] {
        [
            "de": .alphabetic_de,
            "en": .alphabetic_en,
            "it": .alphabetic_it,
            "sv": .alphabetic_sv
        ]
    }
    
    open var numericInputSet: NumericKeyboardInputSet {
        getInputSet(in: numericTable, fallback: .numeric_en)
    }
    
    open var numericTable: [String: NumericKeyboardInputSet] {
        [
            "de": .numeric_de,
            "en": .numeric_en,
            "it": .numeric_it,
            "sv": .numeric_sv
        ]
    }
    
    open var symbolicInputSet: SymbolicKeyboardInputSet {
        getInputSet(in: symbolicTable, fallback: .symbolic_en)
    }
    
    open var symbolicTable: [String: SymbolicKeyboardInputSet] {
        [
            "de": .symbolic_de,
            "en": .symbolic_en,
            "it": .symbolic_it,
            "sv": .symbolic_sv
        ]
    }
    
    
    open func getInputSet<Type: KeyboardInputSet>(in table: [String: Type], fallback: Type) -> Type {
        if let set = table[locale.identifier] { return set }
        if let set = table[locale.languageCode ?? "en"] { return set }
        return fallback
    }
}
