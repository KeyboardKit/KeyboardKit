//
//  KeyboardShiftState+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardShiftState {
    
    /**
     The standard button image in a system keyboard.
     */
    var standardButtonImage: Image {
        switch self {
        case .capsLocked: return .shiftCapslocked
        case .lowercased: return .shiftLowercased
        case .uppercased: return .shiftUppercased
        }
    }
}
