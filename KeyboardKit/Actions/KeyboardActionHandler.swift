//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 Keyboard action handlers are used to handle keyboard action
 events that are triggered by the user.
 
 `addTapGesture(for:to:)` and `addLongPressGesture(for:to:)`
 can be used to add action gestures to button views that you
 add to your keyboard extensions. They will send any actions
 that the user triggers to the action handler.
 
 */

import Foundation

public protocol KeyboardActionHandler: AnyObject {

    func handleLongPress(on view: UIView, action: KeyboardAction)
    func handleTap(on view: UIView, action: KeyboardAction)
}

public extension KeyboardActionHandler {
    
    func addKeyboardGestures(for action: KeyboardAction, to view: UIView) {
        addTapGesture(for: action, to: view)
        addLongPressGesture(for: action, to: view)
    }
}

private extension KeyboardActionHandler {
    
    func addLongPressGesture(for action: KeyboardAction, to view: UIView) {
        view.removeLongPressGestureRecognizers()
        view.addLongPressGestureRecognizer { [weak self] in
            self?.handleLongPress(on: view, action: action)
        }
    }
    
    func addTapGesture(for action: KeyboardAction, to view: UIView) {
        view.removeTapGestureRecognizers()
        view.addTapGestureRecognizer { [weak self] in
            self?.handleTap(on: view, action: action)
        }
    }
}
