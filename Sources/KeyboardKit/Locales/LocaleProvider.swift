//
//  LocaleFlagProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-27.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by types that can return a
 certain locale.

 This protocol is implemented by both ``KeyboardLocale`` and
 `Locale` and a few other types in the library.
 */
public protocol LocaleProvider {

    /**
     The locale used by the provider.
     */
    var locale: Locale { get }
}

public extension LocaleProvider {

    /**
     The locale's region code/identifier.
     */
    var regionIdentifier: String? {
        if #available(iOS 16, *) {
            return locale.region?.identifier
        } else {
            return locale.regionCode
        }
    }
}
