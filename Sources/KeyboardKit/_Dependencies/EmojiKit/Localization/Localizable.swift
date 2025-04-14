//
//  Localizable.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation

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
        localizedText(for: localizationKey, in: locale, bundle: bundle)
    }
}

public extension Localizable {
    
    /// The localized text for a certain key, locale and bundle.
    ///
    /// - Parameters:
    ///   - key:
    ///   - locale: The locale to use, by default `.current`.
    ///   - bundle: The bundle that contains the localized content.
    static func localizedText(
        for key: String,
        in locale: Locale = .current,
        bundle: Bundle
    ) -> String {
        let localeBundle = bundle.bundle(for: locale) ?? bundle
        return NSLocalizedString(key, bundle: localeBundle, comment: "")
    }
    
    /// The localized text for a certain key, locale and bundle.
    ///
    /// - Parameters:
    ///   - key:
    ///   - locale: The locale to use, by default `.current`.
    ///   - bundle: The bundle that contains the localized content.
    func localizedText(
        for key: String,
        in locale: Locale = .current,
        bundle: Bundle
    ) -> String {
        Self.localizedText(for: key, in: locale, bundle: bundle)
    }
}
