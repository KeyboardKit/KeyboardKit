//
//  MockKeyboardActionHandler.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit
import UIKit

class MockKeyboardActionHandler: Mock, KeyboardActionHandler {
    
    lazy var handleRef = MockReference(handle)
    lazy var handleDragReg = MockReference(handleDrag)
    lazy var handleTapRef = MockReference(handleTap)
    lazy var handleLongPressRef = MockReference(handleLongPress)
    lazy var handleRepeatRef = MockReference(handleRepeat)
    lazy var giveHapticFeedbackForTapRef = MockReference(giveHapticFeedbackForTap)
    lazy var giveHapticFeedbackForDoubleTapRef = MockReference(giveHapticFeedbackForDoubleTap)
    lazy var giveHapticFeedbackForLongPressRef = MockReference(giveHapticFeedbackForLongPress)
    lazy var giveHapticFeedbackForRepeatRef = MockReference(giveHapticFeedbackForRepeat)
    
    func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) -> Bool {
        true
    }
    
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        invoke(handleRef, args: (gesture, action, sender))
    }
    
    func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {
        invoke(handleDragReg, args: (action, startLocation, currentLocation))
    }
    
    func handleTap(on action: KeyboardAction, view: UIView) {
        invoke(handleTapRef, args: (action, view))
    }
    
    func handleLongPress(on action: KeyboardAction, view: UIView) {
        invoke(handleLongPressRef, args: (action, view))
    }
    
    func handleRepeat(on action: KeyboardAction, view: UIView) {
        invoke(handleRepeatRef, args: (action, view))
    }
    
    func giveHapticFeedbackForTap(on action: KeyboardAction) {
        invoke(giveHapticFeedbackForTapRef, args: action)
    }
    
    func giveHapticFeedbackForDoubleTap(on action: KeyboardAction) {
        invoke(giveHapticFeedbackForDoubleTapRef, args: action)
    }
    
    func giveHapticFeedbackForLongPress(on action: KeyboardAction) {
        invoke(giveHapticFeedbackForLongPressRef, args: action)
    }
    
    func giveHapticFeedbackForRepeat(on action: KeyboardAction) {
        invoke(giveHapticFeedbackForRepeatRef, args: action)
    }
}
