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
 */
@available(*, deprecated, message: "Use input sets directly instead.")
open class EnglishInputSetProvider: InputSetProvider, LocalizedService {
    
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
        self.numericInputSet = .englishNumeric(currency: numericCurrency)
        self.symbolicInputSet = .englishSymbolic(currency: symbolicCurrency)
    }
    
    /**
     The locale identifier.
     */
    public var localeKey = KeyboardLocale.english.id
    
    /**
     The input set to use for alphabetic keyboards.
     */
    public var alphabeticInputSet: AlphabeticInputSet
    
    /**
     The input set to use for numeric keyboards.
     */
    public var numericInputSet: NumericInputSet
    
    /**
     The input set to use for symbolic keyboards.
     */
    public var symbolicInputSet: SymbolicInputSet
}