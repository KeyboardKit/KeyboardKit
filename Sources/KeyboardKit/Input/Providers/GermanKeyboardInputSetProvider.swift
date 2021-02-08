//
//  GermanKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class provides German keyboard input sets.
 */
public class GermanKeyboardInputSetProvider: DeviceSpecificInputSetProvider, LocalizedService {
    
    public init(device: UIDevice = .current) {
        self.device = device
    }
    
    public let device: UIDevice
    public let localeKey: String = LocaleKey.german.key
    
    public func alphabeticInputSet() -> AlphabeticKeyboardInputSet {
        AlphabeticKeyboardInputSet(rows: [
            "qwertzuiopü".chars,
            "asdfghjklöä".chars,
            row(phone: "yxcvbnm", pad: "yxcvbnm,.ß")
        ])
    }
    
    public func numericInputSet() -> NumericKeyboardInputSet {
        NumericKeyboardInputSet(rows: [
            row(phone: "1234567890", pad: "1234567890+"),
            row(phone: "-/:;()€&@“", pad: "„§€%&/()=‘#"),
            row(phone: ".,?!’", pad: "—ˋ´…@;:,.-")
        ])
    }
    
    public func symbolicInputSet() -> SymbolicKeyboardInputSet {
        SymbolicKeyboardInputSet(rows: [
            row(phone: "[]{}#%^*+=", pad: "1234567890*"),
            row(phone: "_\\|~<>$£¥•", pad: "$£¥¿–\\[]{}|"),
            row(phone: ".,?!’", pad: "¡<>≠•^~!?_")
        ])
    }
}
