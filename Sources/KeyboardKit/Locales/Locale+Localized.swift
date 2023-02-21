//
//  Locale+Localized.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-04.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Locale {

    /**
     The full name of this locale in its own words.
     */
    var localizedName: String? {
        localizedString(forIdentifier: identifier)?.capitalized
    }

    /**
     The full name of the provided locale in this locale.
     */
    func localizedName(of locale: Locale) -> String? {
        localizedString(forIdentifier: locale.identifier)?.capitalized
    }

    /**
     The full name of this locale in the provided locale.
     */
    func localizedName(in locale: Locale) -> String? {
        locale.localizedString(forIdentifier: identifier)?.capitalized
    }

    /**
     The language name of this locale in its own words.
     */
    var localizedLanguageName: String? {
        guard let code = languageCode else { return nil }
        return localizedString(forLanguageCode: code)?.capitalized
    }

    /**
     The language name of the provided locale in this locale.
     */
    func localizedLanguageName(of locale: Locale) -> String? {
        guard let code = locale.languageCode else { return nil }
        return localizedString(forLanguageCode: code)?.capitalized
    }

    /**
     The language name of this locale in the provided locale.
     */
    func localizedLanguageName(in locale: Locale) -> String? {
        guard let code = languageCode else { return nil }
        return locale.localizedString(forLanguageCode: code)?.capitalized
    }
}
