//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This is the standard keyboard action handler. It is used by
 `KeyboardInputViewController` by default, if you do not set
 `keyboardActionHandler` to a custom action handler.
 
 This handler uses the standard `KeyboardAction` actions e.g.
 when a user taps or presses down on buttons on the keyboard.
 You can modify this behavior by creating a subclass of this
 class and override `xAction(for:sender:)/handleX(on:sender:)`.
 
 You can enable haptic feedback by providing a haptic config
 when you create an instance of this class. You can override
 the standard behavior by overriding `triggerHapticFeedback`.
 
 You can enable audio feedback, by providing an audio config
 when you create an instance of this class. You can override
 the standard behavior by overriding `triggerAudioFeedback`.
 
 `NOTE` This class inherits `NSObject` to be able to be used
 as `target`, e.g. when saving images.
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
    
    public var textDocumentProxy: UITextDocumentProxy? {
        inputViewController?.textDocumentProxy
    }
    
    
    // MARK: - Types
    
    public typealias GestureAction = () -> Void
    
    
    // MARK: - Properties
    
    /**
     Whether or not the action handler should change back to
     lowercase alphabetic keyboard after next text input.
     
     `NOTE` This logic should be moved to `KeyboardAction`.
     */
    open var shouldChangeToAlphabeticLowercase: Bool {
        switch inputViewController?.keyboardType {
        case .alphabetic(let state): return state == .uppercased
        default: return false
        }
    }
    
    
    // MARK: - Actions
    
    /**
     This is the standard action that is used by the handler
     when a user makes a certain gesture on a certain action.
     */
    open func action(for gesture: KeyboardGesture, action: KeyboardAction, sender: Any?) -> GestureAction? {
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
        return { action(self.inputViewController) }
    }
    
    /**
     This is the standard action that is used by the handler
     when a user long presses on a certain keyboard action.
     */
    open func longPressAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        guard let action = action.standardLongPressAction else { return nil }
        return { action(self.inputViewController) }
    }
    
    /**
     This is the standard action that is used by the handler
     when a user presses and holds a certain keyboard action.
     */
    open func repeatAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        guard let action = action.standardRepeatAction else { return nil }
        return { action(self.inputViewController) }
    }
    
    /**
     This is the standard action that is used by the handler
     when a user taps a certain keyboard action.
     */
    open func tapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        guard let action = action.standardTapAction else { return nil }
        return { action(self.inputViewController) }
    }
    
    
    // MARK: - Action Handling
    
    open func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        guard let gestureAction = self.action(for: gesture, action: action, sender: sender) else { return }
        gestureAction()
        triggerAnimation(for: gesture, on: action, sender: sender)
        triggerAudioFeedback(for: gesture, on: action, sender: sender)
        triggerHapticFeedback(for: gesture, on: action, sender: sender)
    }
    
    @available(*, deprecated, message: "Use handle(_ gesture:on:sender:) instead")
    open func handleLongPress(on action: KeyboardAction, view: UIView) {
        handle(.longPress, on: action, sender: view)
    }
    
    @available(*, deprecated, message: "Use handle(_ gesture:on:sender:) instead")
    open func handleRepeat(on action: KeyboardAction, view: UIView) {
        handle(.repeatPress, on: action, sender: view)
    }
    
    @available(*, deprecated, message: "Use handle(_ gesture:on:sender:) instead")
    open func handleTap(on action: KeyboardAction, view: UIView) {
        handle(.tap, on: action, sender: view)
    }
    
    
    // MARK: - Feedback
    
    open func triggerAnimation(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        (sender as? KeyboardButton)?.animateStandardTap()
    }
    
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        if action.isDeleteAction { return audioConfiguration.deleteFeedback.trigger() }
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
    
    
    // MARK: - DEPRECATED
    
    @available(*, deprecated, message: "Use action(for sender:) instead")
    open func action(for gesture: KeyboardGesture, action: KeyboardAction, view: UIView) -> GestureAction? {
        self.action(for: gesture, action: action, sender: view)
    }
    
    @available(*, deprecated, message: "Use triggerAnimation(for:on:sender:) instead")
    open func animationButtonTap(for view: UIView) {
        triggerAnimation(for: .tap, on: .none, sender: view)
    }
    
    @available(*, deprecated, message: "Use longPressAction(for sender:) instead")
    open func longPressAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        tapAction(for: action, view: view)
    }
    
    @available(*, deprecated, message: "Use repeatAction(for sender:) instead")
    open func repeatAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        guard action == .backspace else { return nil }
        return tapAction(for: action, view: view)
    }
    
    @available(*, deprecated, message: "Use tapAction(for sender:) instead")
    open func tapAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        return { action.standardTapAction?(self.inputViewController) }
    }
    
    @available(*, deprecated, message: "Use triggerAudioFeedback(for:on:sender:) instead")
    open func triggerAudioFeedback(for action: KeyboardAction) {
        triggerAudioFeedback(for: .tap, on: action, sender: nil)
    }
    
    @available(*, deprecated, message: "Use triggerHapticFeedback(for:on:sender:) instead")
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        triggerHapticFeedback(for: gesture, on: action, sender: nil)
    }
}
