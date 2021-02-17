//
//  DeviceSpecificInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol is just a util protocol that extends the type
 that implements it with more functionality.
 */
public protocol DeviceSpecificInputSetProvider: KeyboardInputSetProvider {
    
    var device: UIDevice { get }
}

public extension DeviceSpecificInputSetProvider {
    
    func row(_ chars: String) -> KeyboardInputRow {
        row(chars.chars)
    }
    
    func row(_ chars: [String]) -> KeyboardInputRow {
        KeyboardInputRow(chars)
    }
    
    func row(phone: String, pad: String) -> KeyboardInputRow {
        KeyboardInputRow(device.isPhone ? phone.chars : pad.chars)
    }
}
