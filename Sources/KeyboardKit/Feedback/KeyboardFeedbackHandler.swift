//
//  KeyboardFeedbackHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

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
     on the provided `action`, given the `actionProvider`.
     
     The `actionProvider` param must be provided to give the
     handler information on whether or not an action will be
     called when the `gesture` is performed on the `action`.
     */
    func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, actionProvider: GestureActionProvider)
    
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     
     Unlike the `triggerFeedback` function that requires you
     to provide an `actionProvider`, this function should be
     triggering the proper user feedback regardless of if an
     action will actually be performed or not. This could be
     used to for instance let the user try out how a gesture
     will behave for a certain action.
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
