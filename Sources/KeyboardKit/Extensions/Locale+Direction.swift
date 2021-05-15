//
//  Locale+Directions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Locale {
    
    var characterDirection: LanguageDirection {
        Locale.characterDirection(forLanguage: languageCode ?? "")
    }
    
    var isBottomToTop: Bool {
        lineDirection == .bottomToTop
    }
    
    var isLeftToRight: Bool {
        characterDirection == .rightToLeft
    }
    
    var isRightToLeft: Bool {
        characterDirection == .rightToLeft
    }
    
    var isTopToBottom: Bool {
        lineDirection == .topToBottom
    }
    
    var lineDirection: LanguageDirection {
        Locale.lineDirection(forLanguage: languageCode ?? "")
    }
}
