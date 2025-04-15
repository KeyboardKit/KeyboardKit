//
//  Previews+Dictation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-19.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension DictationContext {

    static var preview: DictationContext = {
        DictationContext()
    }()
}

public extension DictationService where Self == Dictation.DisabledDictationService {

    static var preview: Self {
        Dictation.DisabledDictationService()
    }
}
