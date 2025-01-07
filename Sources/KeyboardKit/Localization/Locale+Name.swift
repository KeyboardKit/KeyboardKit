//
//  Locale+Name.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-09.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Locale {

    /// The full name of this locale in its own language.
    var localizedName: String? {
        localizedName(in: self)
    }

    /// The full name of this locale in another locale.
    func localizedName(
        in locale: Locale
    ) -> String? {
        if identifier == "ckb_PC" {
            let sorani = Locale.kurdish_sorani
            let name = sorani.localizedName(in: locale) ?? "Kurdish Sorani"
            return name + " (PC)"
        }
        return locale.localizedString(forIdentifier: identifier)
    }

    /// The language name of this locale in its own language.
    var localizedLanguageName: String? {
        localizedLanguageName(in: self)
    }
    /// The language name of this locale in another locale.
    func localizedLanguageName(
        in locale: Locale
    ) -> String? {
        guard let languageCode else { return nil }
        return locale.localizedString(forLanguageCode: languageCode)
    }
}
