//
//  KeyboardCasing+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardCasing {
    
    /**
     The standard keyboard button image when used with shift.
     */
    var standardButtonImage: Image {
        switch self {
        case .auto: return .shiftLowercased
        case .capsLocked: return .shiftCapslocked
        case .lowercased: return .shiftLowercased
        case .neutral: return .shiftLowercased
        case .uppercased: return .shiftUppercased
        }
    }
}
