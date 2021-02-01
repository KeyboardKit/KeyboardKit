//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This action handler provides standard ways of how to handle
 keyboard actions.
 
 You can inherit this class and override any implementations
 to customize the standard behavior.
 
 You can provide a custom `haptic` and `audio` configuration
 when you create an instance of this class. The standard aim
 at mimicing the behavior of a native keyboard. You can also
 provide a custom `spaceDragSensitivity`.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(
        keyboardContext: KeyboardContext,
        keyboardBehavior: KeyboardBehavior,
        autocompleteAction: @escaping () -> Void,
        changeKeyboardTypeAction: @escaping (KeyboardType) -> Void,
        hapticConfiguration: HapticFeedbackConfiguration = .standard,
        audioConfiguration: AudioFeedbackConfiguration = .standard,
        spaceDragSensitivity: SpaceDragSensitivity = .medium) {
        self.keyboardContext = keyboardContext
        self.keyboardBehavior = keyboardBehavior
        self.autocompleteAction = autocompleteAction
        self.changeKeyboardTypeAction = changeKeyboardTypeAction
        self.hapticConfiguration = hapticConfiguration
        self.audioConfiguration = audioConfiguration
        self.spaceDragSensitivity = spaceDragSensitivity
    }
    
    
    // MARK: - Dependencies
    
    public let audioConfiguration: AudioFeedbackConfiguration
    public let keyboardBehavior: KeyboardBehavior
    public let keyboardContext: KeyboardContext
    public let hapticConfiguration: HapticFeedbackConfiguration
    public let spaceDragSensitivity: SpaceDragSensitivity
    
    public let autocompleteAction: () -> Void
    public let changeKeyboardTypeAction: (KeyboardType) -> Void
    
    
    // MARK: - Properties
    
    private var currentDragStartLocation: CGPoint?
    
    private var currentDragTextPositionOffset: Int = 0
    
    private var keyboardInputViewController: KeyboardInputViewController { .shared }
    
    
    // MARK: - Types
    
    public typealias GestureAction = KeyboardAction.GestureAction
    
    
    // MARK: - KeyboardActionHandler
    
    public func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) -> Bool {
        self.action(for: gesture, on: action) != nil
    }
    
    /**
     Handle a certain `gesture` on a certain `action`
     */
    open func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        guard let gestureAction = self.action(for: gesture, on: action) else { return }
        gestureAction(keyboardInputViewController)
        triggerAudioFeedback(for: gesture, on: action, sender: sender)
        triggerHapticFeedback(for: gesture, on: action, sender: sender)
        autocompleteAction()
        tryEndSentence(after: gesture, on: action)
        tryChangeKeyboardType(after: gesture, on: action)
        tryRegisterEmoji(after: gesture, on: action)
    }
    
    /**
     Handle a drag gesture on a certain action, from a start
     location to the drag gesture's current location.
     */
    open func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {
        switch action {
        case .space: handleSpaceCursorDragGesture(from: startLocation, to: currentLocation)
        default: break
        }
    }
    
    /**
     This function is called from `handleDrag` and moves the
     text cursor according to the last handled offset.
     */
    open func handleSpaceCursorDragGesture(from startLocation: CGPoint, to currentLocation: CGPoint) {
        tryStartNewSpaceCursorDragGesture(from: startLocation, to: currentLocation)
        let dragDelta = startLocation.x - currentLocation.x
        let textPositionOffset = Int(dragDelta / CGFloat(spaceDragSensitivity.points))
        guard textPositionOffset != currentDragTextPositionOffset else { return }
        let offsetDelta = textPositionOffset - currentDragTextPositionOffset
        keyboardContext.textDocumentProxy.adjustTextPosition(byCharacterOffset: -offsetDelta)
        currentDragTextPositionOffset = textPositionOffset
    }
    
    
    // MARK: - Actions
    
    /**
     This is the standard action that is used by the handler
     when a gesture is performed on a certain action.
     */
    open func action(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch gesture {
        case .doubleTap: return action.standardDoubleTapAction
        case .longPress: return action.standardLongPressAction
        case .repeatPress: return action.standardRepeatAction
        case .tap: return action.standardTapAction
        }
    }
    
    
    // MARK: - Action Handling
    
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        if action == .backspace { return audioConfiguration.deleteFeedback.trigger() }
        if action.isInputAction { return audioConfiguration.inputFeedback.trigger() }
        if action.isSystemAction { return audioConfiguration.systemFeedback.trigger() }
    }
    
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        switch gesture {
        case .doubleTap: hapticConfiguration.doubleTapFeedback.trigger()
        case .longPress: hapticConfiguration.longPressFeedback.trigger()
        case .repeatPress: hapticConfiguration.repeatFeedback.trigger()
        case .tap: hapticConfiguration.tapFeedback.trigger()
        }
    }
    
    open func triggerHapticFeedbackForLongPressOnSpaceDragGesture() {
        hapticConfiguration.longPressOnSpaceFeedback.trigger()
    }
    
    open func tryEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard keyboardBehavior.shouldEndSentence(for: keyboardContext, after: gesture, on: action)
        else { return }
        keyboardContext.textDocumentProxy.endSentence()
    }
    
    open func tryChangeKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard keyboardBehavior.shouldSwitchToPreferredKeyboardType(for: keyboardContext, after: gesture, on: action)
        else { return }
        let newType = keyboardBehavior.preferredKeyboardType(for: keyboardContext, after: gesture, on: action)
        changeKeyboardTypeAction(newType)
    }
    
    // TODO: Unit test
    open func tryRegisterEmoji(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard gesture == .tap else { return }
        switch action {
        case .emoji(let emoji): return EmojiCategory.frequentEmojiProvider.registerEmoji(emoji)
        default: return
        }
    }
}


// MARK: - Private Functions

private extension StandardKeyboardActionHandler {

    private func tryStartNewSpaceCursorDragGesture(from startLocation: CGPoint, to currentLocation: CGPoint) {
        let isNewDrag = currentDragStartLocation != startLocation
        currentDragStartLocation = startLocation
        guard isNewDrag else { return }
        currentDragTextPositionOffset = 0
        triggerHapticFeedbackForLongPressOnSpaceDragGesture()
    }
}
