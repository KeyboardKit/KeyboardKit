//
//  KeyboardLayout+DisabledService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
public extension KeyboardLayoutService where Self == KeyboardLayout.DisabledService {

    static var disabled: Self {
        KeyboardLayout.DisabledService()
    }
}

extension KeyboardLayout {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
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
