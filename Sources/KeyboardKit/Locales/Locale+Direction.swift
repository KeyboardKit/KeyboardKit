//
//  Locale+Directions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

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
     Whether or not the line direction is `.topToBottom`.
     */
    var isTopToBottom: Bool {
        lineDirection == .topToBottom
    }
    
    /**
     Get the line direction of the locale.
     */
    var lineDirection: LanguageDirection {
        Locale.lineDirection(forLanguage: languageCode ?? "")
    }
}
