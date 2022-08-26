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
 
 Since currencies can vary between English keyboards, you have
 the option to override the currency symbols that are used in the . You can provide
 a `numericCurrency` that will be used for numeric keyboards,
 and a `symbolicCurrency` that will be used for symbolic. By
 default, `$` is used for numeric and `£` for symbolic.
 
 KeyboardKit Pro adds a provider for each ``KeyboardLocale``
 Check out the demo app to see them in action.
 */
public class EnglishInputSetProvider: InputSetProvider, LocalizedService {
    
    /**
     Create an English input set provider.
     
     - Parameters:
       - numericCurrency: The currency to use for the numeric input set.
       - symbolicCurrency: The currency to use for the symbolic input set.
     */
    public init(
        numericCurrency: String = "$",
        symbolicCurrency: String = "£"
    ) {
        self.alphabeticInputSet = .english
        self.numericInputSet = .english(currency: numericCurrency)
        self.symbolicInputSet = .english(currency: symbolicCurrency)

        self._numericCurrency = numericCurrency
        self._symbolicCurrency = symbolicCurrency
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


    // MARK: - Deprecated

    private let _numericCurrency: String
    private let _symbolicCurrency: String

    /**
     The currency to use for the numeric input set.
     */
    @available(*, deprecated, message: "This is no longer used.")
    public var numericCurrency: String { _numericCurrency }

    /**
     The currency to use for the symbolic input set.
     */
    @available(*, deprecated, message: "This is no longer used.")
    public var symbolicCurrency: String { _symbolicCurrency }
}
