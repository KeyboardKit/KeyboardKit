//
//  Localizable.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol is implemented by resource-localized types.
public protocol Localizable {
    
    /// The `Localizable.strings` key to use when localizing.
    var localizationKey: String { get }
}

public extension Localizable {

    /// The localized name for the current locale and bundle.
    var localizedName: String {
        localizedName(in: .current)
    }

    /// The localized name for a certain locale and bundle.
    ///
    /// - Parameters:
    ///   - locale: The locale to use, by default `.current`.
    ///   - bundle: The bundle that contains the localized content.
    func localizedName(
        in locale: Locale = .current,
        bundle: Bundle
    ) -> String {
        let key = localizationKey
        let localeBundle = bundle.bundle(for: locale) ?? bundle
        return NSLocalizedString(key, bundle: localeBundle, comment: "")
    }
}
