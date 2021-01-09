//
//  KeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 keyboard layouts for the keyboard extension's current state.
 
 KeyboardKit registers a standard protocol implementation in
 the keyboard context when the extension is started. You can
 replace this at any time, by applying a new instance to the
 context's `keyboardLayoutProvider` property.
 
 `IMPORTANT` This is a best effort experimental feature that
 can be redesigned at any time before KK 4.0.
 */
public protocol KeyboardLayoutProvider: AnyObject {
    
    func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout
}
