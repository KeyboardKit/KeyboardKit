//
//  DisabledKeyboardDictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This disabled service can be used as a placeholder when you
 don't have access to a real dictation service.

 KeyboardKit Pro unlocks a ``StandardDictationService`` plus
 a ``StandardKeyboardDictationService`` when a valid license
 is registered.
 */
public class DisabledKeyboardDictationService: KeyboardDictationService {

    public func startDictationFromKeyboard() throws {}

    public func performDictationInApp() throws {}

    public func completeDictationInKeyboard() throws {}
}
