//
//  SwedishKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class provides Swedish keyboard input sets.
 */
public class SwedishKeyboardInputSetProvider: DeviceSpecificInputSetProvider, LocalizedService {
    
    public init(device: UIDevice = .current) {
        self.device = device
    }
    
    public let device: UIDevice
    public let localeKey: String = LocaleKey.swedish.key
    
    public func alphabeticInputSet() -> AlphabeticKeyboardInputSet {
        AlphabeticKeyboardInputSet(rows: [
            "qwertyuiopå".chars,
            "asdfghjklöä".chars,
            row(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    public func numericInputSet() -> NumericKeyboardInputSet {
        NumericKeyboardInputSet(rows: [
            row(phone: "1234567890", pad: "1234567890`"),
            device.isPhone
                ? "-/:;()".chars + ["kr"] + "&@“".chars
                : "@#".chars + ["kr"] + "&*()’”+•".chars,
            row(phone: ".,?!’", pad: "%_-=/;:,.")
        ])
    }
    
    public func symbolicInputSet() -> SymbolicKeyboardInputSet {
        SymbolicKeyboardInputSet(rows: [
            row(phone: "[]{}#%^*+=", pad: "1234567890´"),
            row(phone: "_\\|~<>€$¥•", pad: "€$£^[]{}—˚…"),
            row(phone: ".,?!’", pad: "§|~≠\\<>!?")
        ])
    }
}
