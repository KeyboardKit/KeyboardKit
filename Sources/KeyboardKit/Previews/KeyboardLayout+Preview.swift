//
//  PreviewKeyboardLayoutProvider+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-08-26.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {

    /**
     This value can be used to preview keyboards. Do not use
     it in other situations.
     */
    static var preview: KeyboardLayout {
        PreviewKeyboardLayoutProvider().keyboardLayout(for: .preview)
    }
}
