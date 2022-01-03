//
//  DeviceSpecificInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol extends `KeyboardInputSetProvider` and can be
 implemented by any provider that bases its input set on the
 device being used.
 */
public protocol DeviceSpecificInputSetProvider: KeyboardInputSetProvider {
    
    /**
     The device being used.
     */
    var device: UIDevice { get }
}

public extension DeviceSpecificInputSetProvider {
    
    /**
     Create an input row from a string, which is mapped to a
     `.character` array.
     */
    func row(_ chars: String) -> KeyboardInputRow {
        row(chars.chars)
    }
    
    /**
     Create an input row from a lowercased and an uppercased
     string, which are mapped to `.character` arrays.
     */
    func row(lowercased: String, uppercased: String) -> KeyboardInputRow {
        row(lowercased: lowercased.chars,
            uppercased: uppercased.chars)
    }
    
    /**
     Create an input row from a string array, that is mapped
     to a `KeyboardInputRow` array.
     */
    func row(_ chars: [String]) -> KeyboardInputRow {
        KeyboardInputRow(chars)
    }
    
    /**
     Create an input row from a lowercased and an uppercased
     arrays, which are mapped to `KeyboardInputRow` arrays.
     */
    func row(lowercased: [String], uppercased: [String]) -> KeyboardInputRow {
        KeyboardInputRow(
            lowercased: lowercased,
            uppercased: uppercased)
    }
    
    /**
     Create an input row from phone and pad-specific strings.
     */
    func row(phone: String, pad: String) -> KeyboardInputRow {
        KeyboardInputRow(device.isPhone ? phone.chars : pad.chars)
    }
}
