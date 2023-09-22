//
//  Locale+Direction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Locale {

    /// Get the locale character direction.
    var characterDirection: LanguageDirection {
        Locale.characterDirection(forLanguage: languageCode ?? "")
    }

    /// Whether or not the line direction is `.bottomToTop`.
    var isBottomToTop: Bool {
        lineDirection == .bottomToTop
    }

    /// Whether or not the line direction is `.topToBottom`.
    var isTopToBottom: Bool {
        lineDirection == .topToBottom
    }

    /// Whether or not the char direction is `.leftToRight`.
    var isLeftToRight: Bool {
        characterDirection == .leftToRight
    }

    /// Whether or not the char direction is `.rightToLeft`.
    var isRightToLeft: Bool {
        characterDirection == .rightToLeft
    }

    /// Get the locale line direction.
    var lineDirection: LanguageDirection {
        Locale.lineDirection(forLanguage: languageCode ?? "")
    }
}
