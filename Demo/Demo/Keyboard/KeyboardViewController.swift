//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This controller inherits ``DemoKeyboardViewController`` and
 uses the standard demo configuration to generate a keyboard
 where ``DemoKeyboardView`` mimics a native English keyboard.

 Since the ``DemoKeyboardViewController`` sets up a standard
 configuration, this class doesn't have to override anything.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.
 
 Note that this demo adds KeyboardKit as a local package, to
 make it easy to test and develop the library from this demo.
 */
class KeyboardViewController: DemoKeyboardViewController {}
