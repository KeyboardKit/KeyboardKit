//
//  KeyboardAction+InputCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-30.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardAction {
    
    /**
     The text that should be presented in a secondary action
     callout as users long press on the action.
     */
    var inputCalloutText: String? {
        switch self {
        case .character(let char): return char
        case .emoji(let emoji): return emoji.char
        default: return nil
        }
    }
}
