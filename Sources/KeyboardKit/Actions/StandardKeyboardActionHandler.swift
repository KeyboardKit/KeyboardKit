//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class is used by default, if you do not apply a custom
 action handler to your `KeyboardViewController`, by setting
 `keyboardActionHandler` to a custom handler.
 
 This handler uses the default actions when keyboard actions
 are tapped, long pressed or repeated. You can adjust action
 handling by It can be adjusted by
 creating a subclass of this action handler and override the
 `xAction(for:)` and `handleX(on:)` functions.
 
 You can enable haptic feedback by providing haptic feedback
 types for taps and long presses when you create an instance
 of this class. You can also adjust the standard behavior by
 overriding the two `giveHapticFeedbackForX()` functions.
 
 IMPORTANT: This class must inherit `NSObject` to be able to
 set itself as a target, e.g. when saving images to photos.
 
 `TODO`: Test the haptic and audio configuration.
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
    
    public typealias GestureAction = (() -> Void)
    
    
    // MARK: - Actions
    
    open func action(for gesture: KeyboardGesture, action: KeyboardAction, view: UIView) -> GestureAction? {
        switch gesture {
        case .longPress: return longPressAction(for: action, view: view)
        case .repeatPress: return repeatAction(for: action, view: view)
        case .tap: return tapAction(for: action, view: view)
        }
    }
    
    open func longPressAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        tapAction(for: action, view: view)
    }
    
    open func repeatAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        guard action == .backspace else { return nil }
        return tapAction(for: action, view: view)
    }
    
    open func tapAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        inputViewControllerAction(for: action) ?? textDocumentProxyAction(for: action)
    }
    
    
    // MARK: - Action Handling
    
    open func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, view: UIView) {
        guard let gestureAction = self.action(for: gesture, action: action, view: view) else { return }
        gestureAction()
        animationButtonTap(for: view)
        triggerAudioFeedback(for: action)
        triggerHapticFeedback(for: gesture, on: action)
    }
    
    open func handleLongPress(on action: KeyboardAction, view: UIView) {
        handle(.longPress, on: action, view: view)
    }
    
    open func handleRepeat(on action: KeyboardAction, view: UIView) {
        handle(.repeatPress, on: action, view: view)
    }
    
    open func handleTap(on action: KeyboardAction, view: UIView) {
        handle(.tap, on: action, view: view)
    }
    
    
    // MARK: - Feedback
    
    open func animationButtonTap(for view: UIView) {
        (view as? KeyboardButton)?.animateStandardTap()
    }
    
    open func triggerAudioFeedback(for action: KeyboardAction) {
        if action.isDeleteAction { return audioConfiguration.deleteFeedback.trigger() }
        if action.isInputAction { return audioConfiguration.inputFeedback.trigger() }
        if action.isSystemAction { return audioConfiguration.systemFeedback.trigger() }
    }
    
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        switch gesture {
        case .tap: hapticConfiguration.tapFeedback.trigger()
        case .longPress: hapticConfiguration.longPressFeedback.trigger()
        case .repeatPress: hapticConfiguration.repeatFeedback.trigger()
        }
    }
    
    
    // MARK: - Deprecated
    
    @available(*, deprecated, message: "Use configuration-based init instead")
    public init(
        inputViewController: UIInputViewController,
        tapHapticFeedback: HapticFeedback = .none,
        longPressHapticFeedback: HapticFeedback = .none,
        repeatHapticFeedback: HapticFeedback = .none) {
        self.inputViewController = inputViewController
        self.audioConfiguration = .noFeedback
        self.hapticConfiguration = HapticFeedbackConfiguration(
            tapFeedback: tapHapticFeedback,
            longPressFeedback: longPressHapticFeedback,
            repeatFeedback: repeatHapticFeedback
        )
    }
    
    @available(*, deprecated, message: "Use triggerHapticFeedback(for:on:) instead")
    open func giveHapticFeedbackForLongPress(on action: KeyboardAction) {
        triggerHapticFeedback(for: .longPress, on: action)
    }
    
    @available(*, deprecated, message: "Use triggerHapticFeedback(for:on:) instead")
    open func giveHapticFeedbackForRepeat(on action: KeyboardAction) {
        triggerHapticFeedback(for: .repeatPress, on: action)
    }
    
    @available(*, deprecated, message: "Use triggerHapticFeedback(for:on:) instead")
    open func giveHapticFeedbackForTap(on action: KeyboardAction) {
        triggerHapticFeedback(for: .tap, on: action)
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
