//
//  MockKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import KeyboardKit
import MockingKit

class MockKeyboardActionHandler: Mock, KeyboardActionHandler {
    
    lazy var handleRef = MockReference(handle)
    lazy var handleDragReg = MockReference(handleDrag)
    lazy var giveHapticFeedbackForTapRef = MockReference(giveHapticFeedbackForTap)
    lazy var giveHapticFeedbackForDoubleTapRef = MockReference(giveHapticFeedbackForDoubleTap)
    lazy var giveHapticFeedbackForLongPressRef = MockReference(giveHapticFeedbackForLongPress)
    lazy var giveHapticFeedbackForRepeatRef = MockReference(giveHapticFeedbackForRepeat)
    
    func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        true
    }
    
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction) {
        call(handleRef, args: (gesture, action))
    }
    
    func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {
        call(handleDragReg, args: (action, startLocation, currentLocation))
    }

    func giveHapticFeedbackForTap(on action: KeyboardAction) {
        call(giveHapticFeedbackForTapRef, args: action)
    }
    
    func giveHapticFeedbackForDoubleTap(on action: KeyboardAction) {
        call(giveHapticFeedbackForDoubleTapRef, args: action)
    }
    
    func giveHapticFeedbackForLongPress(on action: KeyboardAction) {
        call(giveHapticFeedbackForLongPressRef, args: action)
    }
    
    func giveHapticFeedbackForRepeat(on action: KeyboardAction) {
        call(giveHapticFeedbackForRepeatRef, args: action)
    }
}
