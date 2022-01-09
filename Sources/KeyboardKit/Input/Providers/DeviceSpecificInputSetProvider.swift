//
//  DeviceSpecificInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol extends `InputSetProvider` and can be used by
 any provider that bases its input set on the current device.
 */
public protocol DeviceSpecificInputSetProvider: InputSetProvider {
    
    /**
     The device being used.
     */
    var device: UIDevice { get }
}

public extension DeviceSpecificInputSetProvider {
    
    /**
     Create an input row from phone and pad-specific strings.
     */
    func row(phone: String, pad: String) -> InputSetRow {
        InputSetRow(device.isPhone ? phone.chars : pad.chars)
    }
    
    /**
     Create an input row from phone and pad-specific strings.
     */
    func row(
        phoneLowercased: String,
        phoneUppercased: String,
        padLowercased: String,
        padUppercased: String) -> InputSetRow {
        InputSetRow(
            lowercased: device.isPhone ? phoneLowercased.chars : padLowercased.chars,
            uppercased: device.isPhone ? phoneUppercased.chars : padUppercased.chars)
    }
}
