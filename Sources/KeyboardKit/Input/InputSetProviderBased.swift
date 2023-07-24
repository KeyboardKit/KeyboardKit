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

 `v8.0` - This protocol and all implementation types will be
 replaced by just providing a couple of `InputSet` values to
 the layout provider.
 */
public protocol InputSetProviderBased {

    /**
     Register a new input set provider.
     */
    func register(inputSetProvider: InputSetProvider)
}
