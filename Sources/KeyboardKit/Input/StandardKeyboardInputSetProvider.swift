//
//  StandardKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This standard keyboard inputset provider is used by default
 by KeyboardKit, and provides the standard input set for the
 current locale, if any. You can inherit and customize it to
 create your own provider that builds on this foundation.
 
 The dictionaries contain the currently supported input sets.
 They are not part of the protocol, but you can use them and
 extend them in your own subclasses.
 */
open class StandardKeyboardInputSetProvider: KeyboardInputSetProvider {
    
    public init(locale: Locale = .current) {
        self.locale = locale
    }
    
    
    private let locale: Locale
    
    
    open var alphabeticInputSet: AlphabeticKeyboardInputSet {
        getInputSet(in: alphabeticTable, fallback: .alphabetic_en)
    }
    
    open var alphabeticTable: [String: AlphabeticKeyboardInputSet] {
        ["en": .alphabetic_en]
    }
    
    open var numericInputSet: NumericKeyboardInputSet {
        getInputSet(in: numericTable, fallback: .numeric_en)
    }
    
    open var numericTable: [String: NumericKeyboardInputSet] {
        ["en": .numeric_en]
    }
    
    open var symbolicInputSet: SymbolicKeyboardInputSet {
        getInputSet(in: symbolicTable, fallback: .symbolic_en)
    }
    
    open var symbolicTable: [String: SymbolicKeyboardInputSet] {
        ["en": .symbolic_en]
    }
    
    
    open func getInputSet<Type: KeyboardInputSet>(in table: [String: Type], fallback: Type) -> Type {
        if let set = table[locale.identifier] { return set }
        if let set = table[locale.languageCode ?? "en"] { return set }
        return fallback
    }
}
