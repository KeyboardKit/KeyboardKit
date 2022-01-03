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
     Create an input row from phone and pad-specific strings.
     */
    func row(phone: String, pad: String) -> KeyboardInputRow {
        KeyboardInputRow(device.isPhone ? phone.chars : pad.chars)
    }
    
    /**
     Create an input row from phone and pad-specific strings.
     */
    func row(
        phoneLowercased: String,
        phoneUppercased: String,
        padLowercased: String,
        padUppercased: String) -> KeyboardInputRow {
        KeyboardInputRow(
            lowercased: device.isPhone ? phoneLowercased.chars : padLowercased.chars,
            uppercased: device.isPhone ? phoneUppercased.chars : padUppercased.chars)
    }
}
