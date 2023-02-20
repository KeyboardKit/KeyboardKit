//
//  InputSetProviderBased.swift
//  KeyboardKit
//  
//
//  Created by Daniel Saidi on 2022-12-29.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol is implemented by services that may depend on
 an ``InputSetProvider`` and must be reconfigured when a new
 input set provider is being used.

 > Note: This will no longer be needed when the library uses
 keyboard layout providers that use their own providers. The
 context provider can then be removed and this as well.
 */
public protocol InputSetProviderBased {

    /**
     Register a new input set provider.
     */
    func register(inputSetProvider: InputSetProvider)
}
