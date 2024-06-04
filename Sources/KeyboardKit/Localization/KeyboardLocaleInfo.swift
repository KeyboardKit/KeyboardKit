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
/// enum and the native ``Foundation/Locale`` type and makes
/// both types able to provide much of the same information.
///
/// This removes the need to know whether to get information
/// from the ``KeyboardLocale`` or the ``Foundation/Locale``
/// for the most cases.
///
/// However, ``KeyboardLocale`` has more KeyboardKit-related
/// information that ``Foundation/Locale`` doesn't know, and
/// the native locale still has much more native information
/// that you can use ``KeyboardLocale/locale`` to access.
public protocol KeyboardLocaleInfo {

    /// The native locale.
    ///
    /// The native ``Foundation/Locale`` type implements the
    /// property by returning itself.
    var locale: Locale { get }
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

public extension Locale {

    var locale: Locale { self }
}
