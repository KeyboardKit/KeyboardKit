//
//  EnglishInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This input set provider returns standard English input sets.
 
 Since currencies can vary between English keyboards, we can
 override the currency symbols that are shown in the numeric
 and symbolic keyboards.
 
 KeyboardKit Pro adds a provider for each ``KeyboardLocale``
 Check out the Pro demo app to see them in action.
 */
public class EnglishInputSetProvider: InputSetProvider, LocalizedService {
    
    /**
     Create an English input set provider.

     This input set supports QWERTY, QWERTZ and AZERTY, with
     QWERTY being the default.
     
     - Parameters:
       - alphabetic: The alphabetic input set to use, by default ``AlphabeticInputSet/english``.
       - numericCurrency: The currency to use for the numeric input set, by default `$`.
       - symbolicCurrency: The currency to use for the symbolic input set, by default `£`.
     */
    public init(
        alphabetic: AlphabeticInputSet = .english,
        numericCurrency: String = "$",
        symbolicCurrency: String = "£"
    ) {
        self.alphabeticInputSet = alphabetic
        self.numericInputSet = .english(currency: numericCurrency)
        self.symbolicInputSet = .english(currency: symbolicCurrency)
    }
    
    /**
     The locale identifier.
     */
    public let localeKey: String = KeyboardLocale.english.id
    
    /**
     The input set to use for alphabetic keyboards.
     */
    public let alphabeticInputSet: AlphabeticInputSet
    
    /**
     The input set to use for numeric keyboards.
     */
    public let numericInputSet: NumericInputSet
    
    /**
     The input set to use for symbolic keyboards.
     */
    public let symbolicInputSet: SymbolicInputSet
}

public extension AlphabeticInputSet {

    /**
     A standard, English input set.
     */
    static let english = AlphabeticInputSet.qwerty
}

public extension NumericInputSet {

    /**
     A standard, English input set.
     */
    static func english(currency: String) -> NumericInputSet {
        .standard(currency: currency)
    }
}

public extension SymbolicInputSet {

    /**
     A standard, English input set.
     */
    static func english(currency: String) -> SymbolicInputSet {
        .standard(currencies: "€\(currency)¥".chars)
    }
}
