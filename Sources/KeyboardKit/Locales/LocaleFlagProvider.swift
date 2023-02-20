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
public protocol LocaleFlagProvider {

    /**
     Get the locale flag symbol.
     */
    var flag: String { get }
}

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
extension Locale: LocaleFlagProvider {}

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
public extension Locale {

    /**
     Get the locale flag symbol.

     This only works if the locale has a region identifier.
     */
    var flag: String {
        countryFlag(for: region?.identifier ?? "")
    }
}

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
extension KeyboardLocale: LocaleFlagProvider {}

private func countryFlag(for countryCode: String) -> String {
    let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value
    let flag = countryCode
        .uppercased()
        .unicodeScalars
        .compactMap { UnicodeScalar(flagBase + $0.value)?.description }
        .joined()
    return flag
}
