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
 dictations between a keyboard extension and its parent app.

 Since keyboard extensions can't access the microphone, your
 keyboard extension must open your app, let your app perform
 dictation and write the text to shared state, then pop back
 to your keyboard to handle the result. This protocol can be
 implemented by classes that supports this type of operation.

 KeyboardKit does not have a standard service as it does for
 other services. It has a ``DisabledKeyboardDictationService``
 set up as a placeholder until a custom one is registered.

 KeyboardKit Pro unlocks a ``StandardDictationService`` plus
 a ``StandardKeyboardDictationService`` when a valid license
 is registered and sets up the keyboard dictation service as
 the main ``KeyboardInputViewController/dictationService``.
 */
public protocol KeyboardDictationService: AnyObject {

    /**
     Call this function to start dictation from the keyboard,
     where microphone access is unavailable.
     */
    func startDictationFromKeyboard() throws

    /**
     Call this function to perform dictation in the main app,
     where microphone access is available.
     */
    func performDictationInApp() throws

    /**
     Call this function to complete dictation, after popping
     back to the keyboard extension from the main app.
     */
    func completeDictationInKeyboard() throws
}
