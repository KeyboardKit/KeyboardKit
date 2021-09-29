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
     The casing's standard button image.
     */
    var standardButtonImage: Image {
        switch self {
        case .auto: return .keyboardShiftLowercased
        case .capsLocked: return .keyboardShiftCapslocked
        case .lowercased: return .keyboardShiftLowercased
        case .neutral: return .keyboardShiftLowercased
        case .uppercased: return .keyboardShiftUppercased
        }
    }
}
