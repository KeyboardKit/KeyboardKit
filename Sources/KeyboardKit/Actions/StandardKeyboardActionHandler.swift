//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This is the standard keyboard action handler, which is used
 by your `KeyboardInputViewController` instance if you don't
 replace its `keyboardActionHandler` with another instance.
 
 The handler uses the standard keyboard actions when actions
 are tapped, long pressed or repeated on your keyboard. This
 behavior can be tweaked by creating a subclass and override
 `xAction(for:)` and `handleX(on:)`.
 
 You can enable haptic feedback by providing haptic feedback
 configuration when you create an instance of the class. You
 can adjust the standard feedback behavior by overriding the
 `triggerHapticFeedback(for:on:)` trigger function.
 
 You can setup audio feedback by providing an audio feedback
 configuration when you create an instance of the class. You
 can adjust the standard feedback behavior by overriding the
 `triggerAudioFeedback(for action: KeyboardAction)` function.
 
 IMPORTANT: This class must inherit `NSObject` to be able to
 set itself as a target, e.g. when saving images to photos.
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
