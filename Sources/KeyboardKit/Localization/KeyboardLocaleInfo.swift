//
//  KeyboardLocaleInfo.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// used to get certain locale-specific information.
///
/// The protocol is implemented by both the ``KeyboardLocale``
/// enum and ``Foundation/Locale`` and makes both types able
/// to provide much of the same information.
public protocol KeyboardLocaleInfo {

    /// The native ``Foundation/Locale`` value.
    var locale: Locale { get }

    /// The locale identifier.
    var localeIdentifier: String { get }

    /// The locale language code.
    var localeLanguageCode: String { get }
}

public extension KeyboardLocaleInfo {

    /// Get the character direction for the locale.
    var characterDirection: Locale.LanguageDirection {
        Locale.characterDirection(forLanguage: locale.languageCode ?? "")
    }

    /// Whether the ``lineDirection`` is `.bottomToTop`.
    var isBottomToTop: Bool {
        lineDirection == .bottomToTop
    }

    /// Whether the ``lineDirection``  is `.topToBottom`.
    var isTopToBottom: Bool {
        lineDirection == .topToBottom
    }

    /// Whether the ``characterDirection``  is `.leftToRight`.
    var isLeftToRight: Bool {
        characterDirection == .leftToRight
    }

    /// Whether the ``characterDirection``  is `.rightToLeft`.
    var isRightToLeft: Bool {
        characterDirection == .rightToLeft
    }

    /// Get the line direction for the locale.
    var lineDirection: Locale.LanguageDirection {
        Locale.lineDirection(forLanguage: locale.languageCode ?? "")
    }

    /// Whether this locale prefers to replace alternate end
    /// quotation delimiters with begin ones.
    var prefersAlternateQuotationReplacement: Bool {
        if locale.identifier.hasPrefix("en") { return false }
        return true
    }
}


// MARK: - Implementing Types

extension Locale: KeyboardLocaleInfo {}
extension KeyboardLocale: KeyboardLocaleInfo {}

public extension KeyboardLocale {

    var localeLanguageCode: String { locale.localeLanguageCode }
}

public extension Locale {

    var locale: Locale { self }
    var localeIdentifier: String { identifier }
    var localeLanguageCode: String { languageCode ?? "" }
}
