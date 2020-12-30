//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This standard keyboard action handler is used by default by
 KeyboardKit, and provides standard handling of actions that
 have a standard behavior. You can inherit it to create your
 own action handler that buids on this foundation.
 
 You can replace the standard `hapticConfiguration` when you
 create an instance of this class. The default configuration
 is `.noFeedback`.
 
 You can replace the standard `audioConfiguration`, when you
 create an instance of this class. The default configuration
 is `.standard`.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(
        behavior: KeyboardActionBehavior = StandardKeyboardActionBehavior(),
        inputViewController: KeyboardInputViewController,
        hapticConfiguration: HapticFeedbackConfiguration = .noFeedback,
        audioConfiguration: AudioFeedbackConfiguration = .standard) {
        self.behavior = behavior
        self.inputViewController = inputViewController
        self.hapticConfiguration = hapticConfiguration
        self.audioConfiguration = audioConfiguration
    }
    
    
    // MARK: - Dependencies
    
    public let behavior: KeyboardActionBehavior
    
    public private(set) weak var inputViewController: KeyboardInputViewController?
    
    private let audioConfiguration: AudioFeedbackConfiguration
    
    private let hapticConfiguration: HapticFeedbackConfiguration
    
    private var context: KeyboardContext? { inputViewController?.context }
    
    
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
        triggerAutocomplete()
        tryEndSentence(after: gesture, on: action)
        tryChangeKeyboardType(after: gesture, on: action)
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
        return nil
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
    
    
    // MARK: - Action Handling
    
    open func triggerAnimation(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        (sender as? KeyboardButton)?.animateStandardTap()
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
    
    open func tryEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard let context = context else { return }
        guard behavior.shouldEndSentence(for: context, after: gesture, on: action) else { return }
        context.textDocumentProxy.endSentence()
    }
    
    open func tryChangeKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard let context = context else { return }
        guard behavior.shouldSwitchToPreferredKeyboardType(for: context, after: gesture, on: action) else { return }
        let newType = behavior.preferredKeyboardType(for: context, after: gesture, on: action)
        inputViewController?.changeKeyboardType(to: newType)
    }
    
    
    // MARK: - Deprecated
    
    @available(*, deprecated, renamed: "handleKeyboardTypeChange")
    open func handleKeyboardSwitch(after gesture: KeyboardGesture, on action: KeyboardAction) {
        tryChangeKeyboardType(after: gesture, on: action)
    }
    
    @available(*, deprecated, message: "Use KeyboardActionBehavior instead")
    open func preferredKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardType? {
        guard let context = context else { return nil }
        return behavior.preferredKeyboardType(for: context, after: gesture, on: action)
    }
}
