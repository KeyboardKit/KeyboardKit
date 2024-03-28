//
//  Keyboard+NextKeyboardController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-25.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

public extension Keyboard {

    /// This class is used as global controller for the next
    /// keyboard operation.
    ///
    /// ``KeyboardInputViewController`` will register itself
    /// as the ``shared`` controller on load, and unregister
    /// itself when it unloads.
    final class NextKeyboardController {
        
        private init() {}
        
        public weak static var shared: UIInputViewController?
    }
}
#endif
