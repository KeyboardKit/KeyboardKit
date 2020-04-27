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
 `KeyboardInputViewController`s by default, if you don't set
 `keyboardActionHandler` to a custom handler.
 
 The handler uses the standard keyboard actions when actions
 are tapped, long pressed or repeated on your keyboard. This
 behavior can be tweaked by creating a subclass and override
 `xAction(for:sender:)` and `handleX(on:sender:)`.
 
 You can enable haptic feedback by providing haptic feedback
 configuration when you create an instance of the class. You
 can adjust the standard feedback behavior by overriding the
 `triggerHapticFeedback(for:on:)` trigger function.
 
 You can setup audio feedback by providing an audio feedback
 configuration when you create an instance of the class. You
 can adjust the standard feedback behavior by overriding the
 `triggerAudioFeedback(for action: KeyboardAction)` function.
 
 `IMPORTANT`: This class must inherit `NSObject`, to be able
 to set itself as target, e.g. when saving images.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(
        inputViewController: UIInputViewController,
        hapticConfiguration: HapticFeedbackConfiguration = .noFeedback,
        audioConfiguration: AudioFeedbackConfiguration = .standard) {
        self.inputViewController = inputViewController
        self.hapticConfiguration = hapticConfiguration
        self.audioConfiguration = audioConfiguration
    }
    
    
    // MARK: - Dependencies
    
    public private(set) weak var inputViewController: UIInputViewController?
    
    
    // MARK: - Properties
    
    private let audioConfiguration: AudioFeedbackConfiguration
    
    private let hapticConfiguration: HapticFeedbackConfiguration
    
    public var textDocumentProxy: UITextDocumentProxy? {
        inputViewController?.textDocumentProxy
    }
    
    
    // MARK: - Types
    
    public typealias GestureAction = () -> Void
    
    
    // MARK: - Actions
    
    open func action(for gesture: KeyboardGesture, action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch gesture {
        case .doubleTap: return doubleTapAction(for: action, sender: sender)
        case .longPress: return longPressAction(for: action, sender: sender)
        case .repeatPress: return repeatAction(for: action, sender: sender)
        case .tap: return tapAction(for: action, sender: sender)
        }
    }
    
    open func doubleTapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        if action != .space { return nil }
        textDocumentProxy?.deleteBackward(times: 1)
        return textDocumentProxyAction(for: .character(". "))
    }
    
    open func longPressAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        tapAction(for: action, sender: sender)
    }
    
    open func repeatAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        if action != .backspace { return nil }
        return tapAction(for: action, sender: sender)
    }
    
    open func tapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        inputViewControllerAction(for: action) ?? textDocumentProxyAction(for: action)
    }
    
    
    // MARK: - Action Handling
    
    open func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        guard let gestureAction = self.action(for: gesture, action: action, sender: sender) else { return }
        gestureAction()
        triggerAnimation(for: gesture, on: action, sender: sender)
        triggerAudioFeedback(for: gesture, on: action, sender: sender)
        triggerHapticFeedback(for: gesture, on: action, sender: sender)
    }
    
    open func handleLongPress(on action: KeyboardAction, view: UIView) {
        handle(.longPress, on: action, sender: view)
    }
    
    open func handleRepeat(on action: KeyboardAction, view: UIView) {
        handle(.repeatPress, on: action, sender: view)
    }
    
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
        inputViewControllerAction(for: action) ?? textDocumentProxyAction(for: action)
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


// MARK: - Private Functions

private extension StandardKeyboardActionHandler {
    
    func inputViewControllerAction(for action: KeyboardAction) -> GestureAction? {
        guard let inputAction = action.standardInputViewControllerAction else { return nil }
        return { inputAction(self.inputViewController) }
    }
    
    func textDocumentProxyAction(for action: KeyboardAction) -> GestureAction? {
        guard let proxyAction = action.standardTextDocumentProxyAction else { return nil }
        return { proxyAction(self.textDocumentProxy) }
    }
}
