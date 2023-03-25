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

 The service will not perform any dictation and throw errors
 whenever you try.
 */
class DisabledKeyboardDictationService: DisabledDictationService, KeyboardDictationService {}
