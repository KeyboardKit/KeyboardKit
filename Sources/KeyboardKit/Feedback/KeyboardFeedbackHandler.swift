//
//  KeyboardFeedbackHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to trigger user feedback when a user performs gestures
 on keyboard actions.
 */
public protocol KeyboardFeedbackHandler {
    
    typealias GestureAction = KeyboardAction.GestureAction
    typealias GestureActionProvider = (KeyboardGesture, KeyboardAction) -> GestureAction?
    
    /**
     Try to trigger user feedback for the provided `gesture`
     on the provided `action`.
     
     The `actionProvider` is used to determine if the action
     will actually trigger an operation for the gesture. The
     handler should only trigger feedback if so is the case.
     */
    func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, actionProvider: GestureActionProvider)
    
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     
     Unlike the `triggerFeedback` function that requires you
     to provide an `actionProvider`, this should trigger the
     proper user feedback regardless of if an action will be
     performed or not. This could e.g. be used to let a user
     try out how a gesture will behave for a certain action.
     */
    func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction)
    
    /**
     Trigger feedback for when space is pressed so long that
     it enters cursor drag state.
     */
    func triggerFeedbackForLongPressOnSpaceDragGesture()
 
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     */
    func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction)
    
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     */
    func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction)
}
#endif
