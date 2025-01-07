//
//  KeyboardAction+InputCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-30.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardAction {
    
    /// The input callout text to present for the action.
    var inputCalloutText: String? {
        switch self {
        case .character(let char): char
        case .emoji(let emoji): emoji.char
        default: nil
        }
    }
}
