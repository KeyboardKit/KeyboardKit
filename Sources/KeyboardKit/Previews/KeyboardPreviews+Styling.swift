//
//  KeyboardPreviews+Styling.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-25.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStyleService where Self == KeyboardPreviews.StyleService {

    static var preview: KeyboardStyleService {
        KeyboardPreviews.StyleService()
    }
}

public extension KeyboardPreviews {
    
    class StyleService: KeyboardStyle.StandardStyleService {

        init() {
            super.init(keyboardContext: .preview)
        }
    }
}
