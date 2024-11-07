//
//  KeyboardPreviews+Styling.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-25.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStyleService where Self == KeyboardPreviews.PreviewKeyboardStyleService {

    static var preview: KeyboardStyleService {
        KeyboardPreviews.PreviewKeyboardStyleService()
    }
}

public extension KeyboardPreviews {
    
    class PreviewKeyboardStyleService: KeyboardStyle.StandardService {

        init() {
            super.init(keyboardContext: .preview)
        }
    }
}
