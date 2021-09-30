//
//  KeyboardAction+InputCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-30.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardAction {
    
    var inputCalloutText: String? {
        switch self {
        case .character(let char): return char
        default: return nil
        }
    }
}
