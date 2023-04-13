//
//  LocaleNameProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to provide localized names for locales.

 Implementing the protocol will extend the implementing type
 with functions that use public `Locale` extensions with the
 same name as these extensions. This protocol aims to expose
 these `Locale` extensions, which are otherwise not included
 in the generated documentation.
 */
public protocol LocaleNameProvider {}

public extension LocaleNameProvider {

    /**
     The full name of a locale in its own language.
     */
    func localizedName(of locale: Locale) -> String? {
        locale.localizedName
    }

    /**
     The full name of a locale in another locale's language.
     */
    func localizedName(of locale: Locale, in other: Locale) -> String? {
        locale.localizedName(in: other)
    }

    /**
     The language name of a locale in its own language.
     */
    func localizedLanguageName(of locale: Locale) -> String? {
        locale.localizedLanguageName
    }

    /**
     The language name of a locale in this locale.
     */
    func localizedLanguageName(of locale: Locale, in other: Locale) -> String? {
        locale.localizedLanguageName(in: other)
    }
}


// MARK: - Locale

public extension Locale {

    /**
     The full name of this locale in its own words.
     */
    var localizedName: String? {
        localizedString(forIdentifier: identifier)?.capitalized
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
     The language name of this locale in the provided locale.
     */
    func localizedLanguageName(in locale: Locale) -> String? {
        guard let code = languageCode else { return nil }
        return locale.localizedString(forLanguageCode: code)?.capitalized
    }
}
