//
//  DeviceKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-16.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol extends ``KeyboardLayoutProvider`` with a way
 for a layout provider to resolve various providers based on
 a ``KeyboardContext`` instance.

 This is for instance used to let a single provider use many
 nested providers and select one depending on the context.
 */
public protocol KeyboardLayoutProviderProxy: KeyboardLayoutProvider {

    /**
     The keyboard layout provider to use for a given context.
     */
    func keyboardLayoutProvider(for context: KeyboardContext) -> KeyboardLayoutProvider
}
