//
//  MockKeyboardActionHandler.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockNRoll

class MockKeyboardActionHandler: Mock, KeyboardActionHandler {
    
    func handleLongPress(on view: UIView, action: KeyboardAction) {
        invoke(handleLongPress, args: (view, action))
    }
    
    func handleTap(on view: UIView, action: KeyboardAction) {
        invoke(handleTap, args: (view, action))
    }
    
    func giveHapticFeedbackForLongPress(on action: KeyboardAction) {
        invoke(giveHapticFeedbackForLongPress, args: action)
    }
    
    func giveHapticFeedbackForTap(on action: KeyboardAction) {
        invoke(giveHapticFeedbackForTap, args: action)
    }
}
