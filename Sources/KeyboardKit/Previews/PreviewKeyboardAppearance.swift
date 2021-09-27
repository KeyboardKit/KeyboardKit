//
//  PreviewKeyboardAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This appearance can be used in previews.
 */
public class PreviewKeyboardAppearance: StandardKeyboardAppearance {
    
    init() {
        super.init(context: .preview)
    }
}
