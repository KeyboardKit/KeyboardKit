//
//  KeyboardLocale+Demo.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-02-16.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKitPro

extension KeyboardLocale {

    /**
     The default keyboard locale depends on if the demo uses
     left-to-right or right-to-left locales.
     */
    static var defaultDemoLocale: KeyboardLocale {
        isRtlKeyboard ? .arabic : .english
    }

    /**
     This demo can either use left-to-right or right-to-left
     locales, based on the keyboard configuration.
     */
    static var demoLocales: [KeyboardLocale] {
        KeyboardLocale.allCases
            .filter { $0.isRightToLeft == isRtlKeyboard }
            .sorted(insertFirst: .english)
    }
}

private extension KeyboardLocale {

    /**
     Determine whether or not the demo is an RTL keyboard.
     */
    static var isRtlKeyboard: Bool {
        Bundle.main.bundleIdentifier?.contains("rtl") == true
    }
}
