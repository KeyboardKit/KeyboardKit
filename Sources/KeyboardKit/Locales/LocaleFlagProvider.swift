//
//  LocaleFlagProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-27.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by types that can return a
 flag for a certain locale.

 This protocol is implemented by both ``KeyboardLocale`` and
 `Locale`, where the implementations differ for some locales.
 */
public protocol LocaleFlagProvider: LocaleProvider {

    /**
     The flag symbol for the ``LocaleProvider/locale``.
     */
    var flag: String { get }
}

public extension LocaleFlagProvider {

    /**
     The standard flag for the ``LocaleProvider/locale``.
     */
    var standardFlag: String {
        countryFlag(for: locale.regionIdentifier ?? "")
    }
}

private func countryFlag(for countryCode: String) -> String {
    let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value
    let flag = countryCode
        .uppercased()
        .unicodeScalars
        .compactMap({ UnicodeScalar(flagBase + $0.value)?.description })
        .joined()
    return flag
}
