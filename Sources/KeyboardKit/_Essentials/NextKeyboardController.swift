//
//  NextKeyboardController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-25.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

public extension Keyboard {

    /**
     This class is used as global state for a "next keyboard"
     operation, since it needs a controller to function.
     
     ``KeyboardInputViewController`` will register itself as
     the ``shared`` controller when it loads, and unregister
     when it unloads.
     */
    final class NextKeyboardController {
        
        private init() {}
        
        public weak static var shared: UIInputViewController?
    }
}
#endif
