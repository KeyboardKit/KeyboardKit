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
    
    /// The short display name of this locale.
    ///
    /// This is the langauge code if any, or the identifier.
    var shortDisplayName: String {
        languageCode ?? identifier
    }

    /// The full name of this locale in another locale.
    func localizedName(
        in locale: Locale
    ) -> String? {
        if identifier == "ckb_PC" {
            let name = Locale.kurdish_sorani.localizedName(in: locale) ?? "Kurdish Sorani"
            return name + " (PC)"
        }
        if identifier == "tg" { return "Shughni Tajik" }
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
