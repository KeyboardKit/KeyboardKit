//
//  NextKeyboardController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-25.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

/**
 This class is used as global state for next keyboard button
 views, since they need an input view controller to function.

 The ``KeyboardInputViewController`` will by register itself
 as the ``shared`` controller in `viewDidLoad`.
 */
final class NextKeyboardController {

    private init() {}

    public weak static var shared: UIInputViewController?
}
#endif
