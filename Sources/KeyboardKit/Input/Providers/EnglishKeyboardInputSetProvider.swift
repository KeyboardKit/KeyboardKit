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
 and a `symbolicCurrency` that will be used for symbolic.
 
 By default, `$` is used for numeric and `£` for symbolic.
 */
public class EnglishKeyboardInputSetProvider: DeviceSpecificInputSetProvider, LocalizedService {
    
    public init(
        device: UIDevice = .current,
        numericCurrency: String = "$",
        symbolicCurrency: String = "£") {
        self.device = device
        self.numericCurrency = numericCurrency
        self.symbolicCurrency = symbolicCurrency
    }
    
    public let device: UIDevice
    public let numericCurrency: String
    public let symbolicCurrency: String
    public let localeKey: String = KeyboardLocale.english.id
    
    public var alphabeticInputSet: AlphabeticKeyboardInputSet {
        AlphabeticKeyboardInputSet(rows: [
            row("qwertyuiop"),
            row("asdfghjkl"),
            row(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    public var numericInputSet: NumericKeyboardInputSet {
        NumericKeyboardInputSet(rows: [
            row("1234567890"),
            row(phone: "-/:;()\(numericCurrency)&@”", pad: "@#\(numericCurrency)&*()’”"),
            row(phone: ".,?!’", pad: "%-+=/;:,.")
        ])
    }
    
    public var symbolicInputSet: SymbolicKeyboardInputSet {
        SymbolicKeyboardInputSet(rows: [
            row(phone: "[]{}#%^*+=", pad: "1234567890"),
            row(phone: "_\\|~<>€\(symbolicCurrency)¥•", pad: "€\(symbolicCurrency)¥_^[]{}"),
            row(phone: ".,?!’", pad: "§|~…\\<>!?")
        ])
    }
}
