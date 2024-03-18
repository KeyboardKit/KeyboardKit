//
//  KeyboardLocale+Sort.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-20.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Collection where Element == KeyboardLocale {

    /// Sort the collection by the items's localized names.
    func sorted() -> [Element] {
        sorted { $0.sortName < $1.sortName }
    }

    /// Sort the collection by the locale's localized names.
    func sorted(in locale: Locale) -> [Element] {
        sorted { $0.sortName(in: locale) < $1.sortName(in: locale) }
    }
}

private extension KeyboardLocale {

    var sortName: String {
        locale.localizedName.lowercased()
    }

    func sortName(in locale: Locale) -> String {
        locale.localizedName(in: locale).lowercased()
    }
}
