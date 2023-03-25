//
//  KeyboardDictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can handle
 dictations between a keyboard and its parent app.

 KeyboardKit does not have a standard service as it does for
 other services. It has a ``DisabledKeyboardDictationService``
 that serves as a placeholder until a real one is registered.

 KeyboardKit Pro unlocks a standard dictation service when a
 license is registered. ``StandardKeyboardDictationService``
 can be used to start a dictation operation in your keyboard,
 perform it in the app and finish it in the keyboard.

 KeyboardKit Pro registers a standard service when a license
 is registered.
 */
protocol KeyboardDictationService: DictationService {}
