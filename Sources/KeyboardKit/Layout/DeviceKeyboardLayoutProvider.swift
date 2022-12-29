//
//  DeviceKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-16.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol extends ``KeyboardLayoutProvider`` with a way
 for a layout provider to resolve various providers based on
 which device type that is currently used.
 */
public protocol DeviceKeyboardLayoutProvider: KeyboardLayoutProvider {

    /**
     The keyboard layout provider to use for a given context.
     */
    func keyboardLayoutProvider(for context: KeyboardContext) -> KeyboardLayoutProvider
}
