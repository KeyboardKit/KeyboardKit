//
//  Emoji+Localization.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {

    /**
     Get the localized name for a certain ``KeyboardLocale``.

     If an emoji is missing an explicit translation, it will
     use the ``unicodeName`` as fallback name.

     To localize the emoji names for a locale, translate all
     emojis in the locale's `Localizable.strings` file, then
     make sure that the `testLocalizedNameForAllEmojis` test
     in `Emoji_LocalizationTests` passes for the locale.
     */
    func localizedName(for locale: KeyboardLocale) -> String {
        localizedName(for: locale.locale)
    }

    /**
     Get the localized name for a certain `Locale`.

     If an emoji is missing an explicit translation, it will
     use the ``unicodeName`` as fallback name, which is most
     often a valid English name.

     To localize the emoji names for a locale, translate all
     emojis in the locale's `Localizable.strings` file.
     */
    func localizedName(for locale: Locale) -> String {
        let key = localizationKey
        let name = KKL10n.text(forKey: key, locale: locale)
        let hasLocalizedName = name != key && name != ""
        let result = hasLocalizedName ? name : unicodeName
        return result?.trimming(.whitespaces) ?? ""
    }

    /**
     Get the key that is to be added to `Localizable.strings`
     to localize the emoji.
     */
    var localizationKey: String {
        "Emoji.\(localizationKeyId ?? "")"
    }

    /**
     Get the key that is to be added to `Localizable.strings`
     to localize the emoji.
     */
    var localizationKeyId: String? {
        unicodeName?.replacingOccurrences(of: " ", with: "")
    }
}
