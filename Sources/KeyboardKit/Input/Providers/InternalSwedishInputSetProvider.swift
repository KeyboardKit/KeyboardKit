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
            row("qwertyuiopå"),
            row("asdfghjklöä"),
            row(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    var numericInputSet: NumericInputSet {
        NumericInputSet(rows: [
            row(phone: "1234567890", pad: "1234567890`"),
            row(phone: "-/:;()".chars + ["kr"] + "&@”".chars,
                pad: "@#".chars + ["kr"] + "&*()’”+•".chars),
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
