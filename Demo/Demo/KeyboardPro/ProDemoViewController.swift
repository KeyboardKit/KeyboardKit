//
//  ProDemoViewController.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-02-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This controller is shared between the two Pro-specific demo
 keyboards and registers a Pro license with multiple locales.

 The `KeyboardPro` demo keyboard lets you test left-to-right
 locales, while `KeyboardProRtl` lets you test right-to-left
 locales.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.
 */
class ProDemoViewController: KeyboardInputViewController {}
