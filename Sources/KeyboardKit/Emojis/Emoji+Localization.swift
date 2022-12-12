//
//  Emoji+Localization.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {

    /**
     Get the key that is to be added to `Localizable.strings`
     to localize the emoji.
     */
    func localizedName(for locale: KeyboardLocale) -> String {
        let key = localizationKey
        let name = KKL10n.text(forKey: key, locale: locale)
        let hasLocalizedName = name != key && name != ""
        let result = hasLocalizedName ? name : unicodeName
        return result?.trimmed() ?? ""
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
