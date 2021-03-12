//
//  SwedishKeyboardInputSetProvider.swift
//  KeyboardKitPro
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
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
            row("qwertyuiopå"),
            row("asdfghjklöä"),
            row(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    public func numericInputSet() -> NumericKeyboardInputSet {
        let phoneCenter: [String] = "-/:;()".chars + ["kr"] + "&@”".chars
        let padCenter: [String] = "@#".chars + ["kr"] + "&*()’”+•".chars
        return NumericKeyboardInputSet(rows: [
            row(phone: "1234567890", pad: "1234567890`"),
            row(device.userInterfaceIdiom == .phone ? phoneCenter : padCenter),
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
