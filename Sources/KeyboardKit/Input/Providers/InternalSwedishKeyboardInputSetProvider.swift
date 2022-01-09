//
//  InternalSwedishKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class provides Swedish keyboard input sets. It is only
 used by previews and is not as complex as the real provider
 in KeyboardKit Pro.
 */
class InternalSwedishKeyboardInputSetProvider: DeviceSpecificInputSetProvider, LocalizedService {
    
    init(device: UIDevice = .current) {
        self.device = device
    }
    
    let device: UIDevice
    let localeKey: String = KeyboardLocale.swedish.id
    
    var alphabeticInputSet: AlphabeticInputSet {
        AlphabeticInputSet(rows: [
            KeyboardInputRow("qwertyuiopå"),
            KeyboardInputRow("asdfghjklöä"),
            row(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    var numericInputSet: NumericInputSet {
        let phoneCenter: [String] = "-/:;()".chars + ["kr"] + "&@”".chars
        let padCenter: [String] = "@#".chars + ["kr"] + "&*()’”+•".chars
        return NumericInputSet(rows: [
            row(phone: "1234567890", pad: "1234567890`"),
            KeyboardInputRow(device.isPhone ? phoneCenter : padCenter),
            row(phone: ".,?!’", pad: "%_-=/;:,.")
        ])
    }
    
    var symbolicInputSet: SymbolicInputSet {
        SymbolicInputSet(rows: [
            row(phone: "[]{}#%^*+=", pad: "1234567890´"),
            row(phone: "_\\|~<>€$£•", pad: "€$£^[]{}—˚…"),
            row(phone: ".,?!’", pad: "§|~≠\\<>!?")
        ])
    }
}
