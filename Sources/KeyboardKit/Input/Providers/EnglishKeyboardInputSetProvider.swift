//
//  EnglishKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class provides English keyboard input sets.
 
 Since currencies can vary between English locales, you have
 the option to override the currency symbol. You can provide
 a `numericCurrency` that will be used for numeric keyboards,
 and a `symbolicCurrency` that will be used for symbolic. By
 default, `$` is used for numeric and `£` for symbolic.
 */
public class EnglishKeyboardInputSetProvider: DeviceSpecificInputSetProvider, LocalizedService {
    
    /**
     Create a provider instance.
     
     - Parameters:
       - device: The device for which the input should apply.
       - numericCurrency: The currency to use for the numeric input set.
       - symbolicCurrency: The currency to use for the symbolic input set.
     */
    public init(
        device: UIDevice = .current,
        numericCurrency: String = "$",
        symbolicCurrency: String = "£") {
        self.device = device
        self.numericCurrency = numericCurrency
        self.symbolicCurrency = symbolicCurrency
    }
    
    /**
     The device for which the input should apply.
     */
    public let device: UIDevice
    
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
    public var alphabeticInputSet: AlphabeticKeyboardInputSet {
        AlphabeticKeyboardInputSet(rows: [
            KeyboardInputRow("qwertyuiop"),
            KeyboardInputRow("asdfghjkl"),
            row(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    /**
     The input set to use for numeric keyboards.
     */
    public var numericInputSet: NumericKeyboardInputSet {
        NumericKeyboardInputSet(rows: [
            KeyboardInputRow("1234567890"),
            row(phone: "-/:;()\(numericCurrency)&@”", pad: "@#\(numericCurrency)&*()’”"),
            row(phone: ".,?!’", pad: "%-+=/;:,.")
        ])
    }
    
    /**
     The input set to use for symbolic keyboards.
     */
    public var symbolicInputSet: SymbolicKeyboardInputSet {
        SymbolicKeyboardInputSet(rows: [
            row(phone: "[]{}#%^*+=", pad: "1234567890"),
            row(phone: "_\\|~<>€\(symbolicCurrency)¥•", pad: "€\(symbolicCurrency)¥_^[]{}"),
            row(phone: ".,?!’", pad: "§|~…\\<>!?")
        ])
    }
}
