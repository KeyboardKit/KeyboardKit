//
//  Locale+Flag.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-27.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Locale {

    /**
     The locale's flag symbol.
     */
    var flag: String {
        countryFlag(for: regionIdentifier ?? "")
    }

    /**
     The locale's region code/identifier.
     */
    var regionIdentifier: String? {
        if #available(iOS 16, *) {
            return region?.identifier
        } else {
            return regionCode
        }
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
