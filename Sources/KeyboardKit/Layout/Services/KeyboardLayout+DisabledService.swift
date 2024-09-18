//
//  KeyboardLayout+DisabledService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension KeyboardLayout {
    
    /// This service can be used to disable keyboard layouts
    /// and just use a standard ``BaseService``.
    ///
    /// This service can also be resolved with the shorthand
    /// ``KeyboardLayoutService/disabled``.
    ///
    /// See <doc:Layout-Article> for more information.
    open class DisabledService: KeyboardLayout.BaseService {

        public init() {
            super.init(
                alphabeticInputSet: .qwerty,
                numericInputSet: .numeric(currency: "$"),
                symbolicInputSet: .symbolic(currencies: ["€£¥"])
            )
        }
    }
}
