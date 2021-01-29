//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This action handler is used by default by `KeyboardKit` and
 provides a standard way of handling keyboard actions.
 
 You can provide a custom `haptic` and `audio` configuration
 when you create an instance of this class. The standard aim
 at mimicing the behavior of a native keyboard. You can also
 provide a custom `spaceDragSensitivity`.
 
 You can inherit this class and override any implementations
 to customize the standard behavior.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(
        inputViewController: KeyboardInputViewController,
        hapticConfiguration: HapticFeedbackConfiguration = .standard,
        audioConfiguration: AudioFeedbackConfiguration = .standard,
        spaceDragSensitivity: SpaceDragSensitivity = .medium) {
        self.inputViewController = inputViewController
        self.hapticConfiguration = hapticConfiguration
        self.audioConfiguration = audioConfiguration
        self.spaceDragSensitivity = spaceDragSensitivity
    }
    
    
    // MARK: - Dependencies
    
    @available(*, deprecated, message: "This will be removed")
    public private(set) weak var inputViewController: KeyboardInputViewController?
    
    private let audioConfiguration: AudioFeedbackConfiguration
    private let hapticConfiguration: HapticFeedbackConfiguration
    private let spaceDragSensitivity: SpaceDragSensitivity
    
    
    // MARK: - Properties
    
    private var context: KeyboardContext? { inputViewController?.context }
    private var currentDragStartLocation: CGPoint?
    private var currentDragTextPositionOffset: Int = 0
    
    
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
        gestureAction(.shared)
        triggerAnimation(for: gesture, on: action, sender: sender)
        triggerAudioFeedback(for: gesture, on: action, sender: sender)
        triggerHapticFeedback(for: gesture, on: action, sender: sender)
        triggerAutocomplete()
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
        context?.textDocumentProxy.adjustTextPosition(byCharacterOffset: -offsetDelta)
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
    
    open func triggerAnimation(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        (sender as? UIKeyboardButton)?.animateStandardTap()
    }
    
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        if action == .backspace { return audioConfiguration.deleteFeedback.trigger() }
        if action.isInputAction { return audioConfiguration.inputFeedback.trigger() }
        if action.isSystemAction { return audioConfiguration.systemFeedback.trigger() }
    }
    
    open func triggerAutocomplete() {
        inputViewController?.performAutocomplete()
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
        guard let context = context else { return }
        let behavior = context.keyboardBehavior
        guard behavior.shouldEndSentence(for: context, after: gesture, on: action) else { return }
        context.textDocumentProxy.endSentence()
    }
    
    open func tryChangeKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard let context = context else { return }
        let behavior = context.keyboardBehavior
        guard behavior.shouldSwitchToPreferredKeyboardType(for: context, after: gesture, on: action) else { return }
        let newType = behavior.preferredKeyboardType(for: context, after: gesture, on: action)
        inputViewController?.changeKeyboardType(to: newType)
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
