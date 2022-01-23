//
//  EnglishInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This input set provider provides English input sets.
 
 Since currencies can vary between English locales, you have
 the option to override the currency symbol. You can provide
 a `numericCurrency` that will be used for numeric keyboards,
 and a `symbolicCurrency` that will be used for symbolic. By
 default, `$` is used for numeric and `£` for symbolic.
 */
public class EnglishInputSetProvider: DeviceSpecificInputSetProvider, LocalizedService {
    
    /**
     Create an English input set provider.
     
     - Parameters:
       - numericCurrency: The currency to use for the numeric input set.
       - symbolicCurrency: The currency to use for the symbolic input set.
     */
    public init(
        numericCurrency: String = "$",
        symbolicCurrency: String = "£") {
        self.numericCurrency = numericCurrency
        self.symbolicCurrency = symbolicCurrency
    }
    
    /**
     The currency to use for the numeric input set.
     */
    public let numericCurrency: String
    
    /**
     The currency to use for the symbolic input set.
     */
    public let symbolicCurrency: String
    
    /**
     The locale identifier.
     */
    public let localeKey: String = KeyboardLocale.english.id
    
    /**
     The input set to use for alphabetic keyboards.
     */
    public var alphabeticInputSet: AlphabeticInputSet {
        AlphabeticInputSet(rows: [
            row("qwertyuiop"),
            row("asdfghjkl"),
            row(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    /**
     The input set to use for numeric keyboards.
     */
    public var numericInputSet: NumericInputSet {
        NumericInputSet(rows: [
            row("1234567890"),
            row(phone: "-/:;()\(numericCurrency)&@”", pad: "@#\(numericCurrency)&*()’”"),
            row(phone: ".,?!’", pad: "%-+=/;:!?")
        ])
    }
    
    /**
     The input set to use for symbolic keyboards.
     */
    public var symbolicInputSet: SymbolicInputSet {
        SymbolicInputSet(rows: [
            row(phone: "[]{}#%^*+=", pad: "1234567890"),
            row(phone: "_\\|~<>€\(symbolicCurrency)¥•", pad: "€\(symbolicCurrency)¥_^[]{}"),
            row(phone: ".,?!’", pad: "§|~…\\<>!?")
        ])
    }
}
