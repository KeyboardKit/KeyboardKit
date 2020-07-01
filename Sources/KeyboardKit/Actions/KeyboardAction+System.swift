//
//  KeyboardAction+System.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

public extension KeyboardAction {
    
    /**
     The font that would be used in a system keyboard.
     
     For actions that don't exist on a system level, this is
     just a suggestion, that you can ignore or override.
     */
    var systemFont: UIFont {
        .preferredFont(forTextStyle: systemTextStyle)
    }
    
    /**
     The text style that would be used in a system keyboard.
     
     For actions that don't exist on a system level, this is
     just a suggestion, that you can ignore or override.
    */
    var systemTextStyle: UIFont.TextStyle {
        switch self {
        case .emoji: return .title1
        default: return .title2
        }
    }
}
