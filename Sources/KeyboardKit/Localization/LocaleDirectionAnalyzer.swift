//
//  LocaleDirectionAnalyzer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to analyze the typing directions of locales.

 Implementing the protocol will extend the implementing type
 with functions that use public `Locale` extensions with the
 same names. While you can use the protocol, the main reason
 for having it is to expose these extensions to DocC.
 */
public protocol LocaleDirectionAnalyzer {}

public extension LocaleDirectionAnalyzer {

    /**
     Get the character direction of the locale.
     */
    func characterDirection(
        of locale: Locale
    ) -> Locale.LanguageDirection {
        locale.characterDirection
    }

    /**
     Get the line direction of the locale.
     */
    func lineDirection(
        of locale: Locale
    ) -> Locale.LanguageDirection {
        locale.lineDirection
    }

    /**
     Whether or not the locale line direction is `.bottomToTop`.
     */
    func isBottomToTop(_ locale: Locale) -> Bool {
        locale.isBottomToTop
    }

    /**
     Whether or not the line direction is `.topToBottom`.
     */
    func isTopToBottom(_ locale: Locale) -> Bool {
        locale.isTopToBottom
    }

    /**
     Whether or not the character direction is `.leftToRight`.
     */
    func isLeftToRight(_ locale: Locale) -> Bool {
        locale.isLeftToRight
    }

    /**
     Whether or not the character direction is `.rightToLeft`.
     */
    func isRightToLeft(_ locale: Locale) -> Bool {
        locale.isRightToLeft
    }
}


// MARK: - Locale

public extension Locale {

    /**
     Get the character direction of the locale.
     */
    var characterDirection: LanguageDirection {
        Locale.characterDirection(forLanguage: languageCode ?? "")
    }

    /**
     Whether or not the line direction is `.bottomToTop`.
     */
    var isBottomToTop: Bool {
        lineDirection == .bottomToTop
    }

    /**
     Whether or not the line direction is `.topToBottom`.
     */
    var isTopToBottom: Bool {
        lineDirection == .topToBottom
    }

    /**
     Whether or not the character direction is `.leftToRight`.
     */
    var isLeftToRight: Bool {
        characterDirection == .leftToRight
    }

    /**
     Whether or not the character direction is `.rightToLeft`.
     */
    var isRightToLeft: Bool {
        characterDirection == .rightToLeft
    }

    /**
     Get the line direction of the locale.
     */
    var lineDirection: LanguageDirection {
        Locale.lineDirection(forLanguage: languageCode ?? "")
    }
}
