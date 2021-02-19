//
//  MockKeyboardActionHandler.swift
//  KeyboardKit
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
        call(handleRef, args: (gesture, action, sender))
    }
    
    func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {
        call(handleDragReg, args: (action, startLocation, currentLocation))
    }
    
    func handleTap(on action: KeyboardAction, view: UIView) {
        call(handleTapRef, args: (action, view))
    }
    
    func handleLongPress(on action: KeyboardAction, view: UIView) {
        call(handleLongPressRef, args: (action, view))
    }
    
    func handleRepeat(on action: KeyboardAction, view: UIView) {
        call(handleRepeatRef, args: (action, view))
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
