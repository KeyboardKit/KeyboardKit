//
//  InternalSwedishInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This input set provider provides Swedish input sets.
 
 This class is only used for generating Swedish previews and
 is not as complex as real providers in KeyboardKit Pro.
 */
class InternalSwedishInputSetProvider: DeviceSpecificInputSetProvider, LocalizedService {
    
    let localeKey: String = KeyboardLocale.swedish.id
    
    var alphabeticInputSet: AlphabeticInputSet {
        AlphabeticInputSet(rows: [
            InputSetRow("qwertyuiopå"),
            InputSetRow("asdfghjklöä"),
            row(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    var numericInputSet: NumericInputSet {
        let phoneCenter: [String] = "-/:;()".chars + ["kr"] + "&@”".chars
        let padCenter: [String] = "@#".chars + ["kr"] + "&*()’”+•".chars
        return NumericInputSet(rows: [
            row(phone: "1234567890", pad: "1234567890`"),
            row(phone: phoneCenter, pad : padCenter),
            row(phone: ".,?!’", pad: "%_-=/;:!?")
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
