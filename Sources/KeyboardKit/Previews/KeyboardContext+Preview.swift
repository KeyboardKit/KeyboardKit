//
//  KeyboardContext+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {
    
    /**
     This preview context can be used in SwiftUI previews.
     */
    static var preview: KeyboardContext {
        #if os(iOS) || os(tvOS)
        KeyboardContext(controller: KeyboardInputViewController.preview)
        #else
        KeyboardContext()
        #endif
    }
}
