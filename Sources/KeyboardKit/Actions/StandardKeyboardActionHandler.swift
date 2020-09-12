//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This action handler provides standard action handling for a
 certain action and gesture. You can subclass it to override
 any part that you want to modify with custom logic.
 
 `KeyboardInputViewController` uses this standard handler as
 `keyboardActionHandler` by deafult, but you can replace the
 standard action handling with a custom action handler.
 
 You can enable haptic feedback by providing this class with
 a `hapticConfiguration` and change the standard behavior by
 overriding `triggerHapticFeedback`.
 
 You can enable audio feedback, by providing this class with
 an `audioConfiguration` and change the standard behavior by
 overriding `triggerAudioFeedback`.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(
        inputViewController: KeyboardInputViewController,
        hapticConfiguration: HapticFeedbackConfiguration = .noFeedback,
        audioConfiguration: AudioFeedbackConfiguration = .standard) {
        self.inputViewController = inputViewController
        self.hapticConfiguration = hapticConfiguration
        self.audioConfiguration = audioConfiguration
    }
    
    
    // MARK: - Dependencies
    
    public private(set) weak var inputViewController: KeyboardInputViewController?
    
    private let audioConfiguration: AudioFeedbackConfiguration
    
    private let hapticConfiguration: HapticFeedbackConfiguration
    
    
    // MARK: - Types
    
    public typealias GestureAction = () -> Void
    
    
    // MARK: - KeyboardActionHandler
    
    public func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) -> Bool {
        self.action(for: gesture, on: action, sender: sender) != nil
    }
    
    /**
     Handle a certain `gesture` on a certain `action`
     */
    open func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        guard let gestureAction = self.action(for: gesture, on: action, sender: sender) else { return }
        gestureAction()
        triggerAnimation(for: gesture, on: action, sender: sender)
        triggerAudioFeedback(for: gesture, on: action, sender: sender)
        triggerHapticFeedback(for: gesture, on: action, sender: sender)
        handleKeyboardSwitch(after: gesture, on: action)
        inputViewController?.performAutocomplete()
    }
    
    
    // MARK: - Actions
    
    /**
     This is the standard action that is used by the handler
     when a user makes a certain gesture on a certain action.
     */
    open func action(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch gesture {
        case .doubleTap: return doubleTapAction(for: action, sender: sender)
        case .longPress: return longPressAction(for: action, sender: sender)
        case .repeatPress: return repeatAction(for: action, sender: sender)
        case .tap: return tapAction(for: action, sender: sender)
        }
    }
    
    /**
     This is the standard action that is used by the handler
     when a user double taps a certain keyboard action.
     */
    open func doubleTapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        guard let action = action.standardDoubleTapAction else { return nil }
        return { [weak self] in action(self?.inputViewController) }
    }
    
    /**
     This is the standard action that is used by the handler
     when a user long presses on a certain keyboard action.
     */
    open func longPressAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        guard let action = action.standardLongPressAction else { return nil }
        return { [weak self] in action(self?.inputViewController) }
    }
    
    /**
     This is the standard action that is used by the handler
     when a user presses and holds a certain keyboard action.
     */
    open func repeatAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        guard let action = action.standardRepeatAction else { return nil }
        return { [weak self] in action(self?.inputViewController) }
    }
    
    /**
     This is the standard action that is used by the handler
     when a user taps a certain keyboard action.
     */
    open func tapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        guard let action = action.standardTapAction else { return nil }
        return { [weak self] in action(self?.inputViewController) }
    }
    
    
    // MARK: - Feedback
    
    open func triggerAnimation(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        (sender as? KeyboardButton)?.animateStandardTap()
    }
    
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
    
    
    // MARK: - Keyboard Type Switching
    
    open func handleKeyboardSwitch(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard let type = preferredKeyboardType(after: gesture, on: action) else { return }
        inputViewController?.changeKeyboardType(to: type)
    }
    
    open func preferredKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardType? {
        if shouldChangeToAlphabeticLowercase(after: gesture, on: action) { return .alphabetic(.lowercased) }
        return nil
    }
}


// MARK: - Private Extensions

private extension StandardKeyboardActionHandler {
    
    func shouldChangeToAlphabeticLowercase(after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        guard let type = inputViewController?.context.keyboardType else { return false }
        guard case .alphabetic(.uppercased) = type else { return false }
        guard case .tap = gesture else { return false }
        guard case .character = action else { return false }
        return true
    }
}
