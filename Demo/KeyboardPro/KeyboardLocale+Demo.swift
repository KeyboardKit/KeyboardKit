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
     The default locale depends on if the demo is LTR or RTL.
     */
    static var defaultDemoLocale: KeyboardLocale {
        isRtlDemo ? .arabic : .english
    }

    /**
     The demo locales depend on if the demo is LTR or RTL.
     */
    static var demoLocales: [KeyboardLocale] {
        KeyboardLocale.allCases
            .filter { $0.locale.isRightToLeft == isRtlDemo }
            .sorted(insertFirst: defaultDemoLocale)
    }
}

extension Locale {

    /**
     The default locale depends on if the demo is LTR or RTL.
     */
    static var defaultDemoLocale: Locale {
        KeyboardLocale.defaultDemoLocale.locale
    }
}

extension Collection where Element == Locale {

    /**
     The demo locales depend on if the demo is LTR or RTL.
     */
    static var demoLocales: [Locale] {
        KeyboardLocale.demoLocales.map { $0.locale }
    }
}

private extension KeyboardLocale {

    /**
     Determine whether or not the demo is an RTL keyboard.
     */
    static var isRtlDemo: Bool {
        Bundle.main.bundleIdentifier?.contains("rtl") == true
    }
}
