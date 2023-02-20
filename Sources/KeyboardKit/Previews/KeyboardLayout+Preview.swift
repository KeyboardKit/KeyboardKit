//
//  KeyboardLayout+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-08-26.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {

    /**
     This preview layout can be used in SwiftUI previews.
     */
    static var preview: KeyboardLayout {
        PreviewKeyboardLayoutProvider().keyboardLayout(for: .preview)
    }
}
