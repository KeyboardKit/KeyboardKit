//
//  KeyboardContext+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {
    
    /**
     This property can be used to preview keyboard views. Do
     not use it in other situations.
     */
    static var preview: KeyboardContext {
        KeyboardContext(controller: KeyboardInputViewController.preview)
    }
}
