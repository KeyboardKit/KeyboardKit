//
//  KeyboardLayout+StandardProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension KeyboardLayout {
    
    /// This service can be used to disable keyboard layouts
    /// and just use a standard ``BaseProvider``.
    ///
    /// See <doc:Layout-Article> for more information.
    open class DisabledProvider: KeyboardLayout.BaseProvider {

        public init() {
            super.init(
                alphabeticInputSet: .qwerty,
                numericInputSet: .numeric(currency: "$"),
                symbolicInputSet: .symbolic(currencies: ["€£¥"])
            )
        }
    }
}
