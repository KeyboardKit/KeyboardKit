//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This action handler is used by all `KeyboardViewController`
 instances by default, if you don't explicitly decide to use
 another one. You do this by setting `keyboardActionHandler`
 to a custom action handler.
 
 This action handler uses the default action blocks for each
 keyboard action, if any, as the default tap action. You can
 adjust this behavior by subclassing this class and override
 `tapAction(for:)` and `longPressAction(for:)` to change the
 action blocks to use for each keyboard action. You can also
 override `handleTap(on:)` and `handleLongPress(on:)` if you
 only want to adjust the handling of the various actions.
 
 You can enable haptic feedback by providing haptic feedback
 types for taps and long presses when you create an instance
 of this class. You can also adjust the standard behavior by
 overriding the two `giveHapticFeedback` functions.
 
 */

import UIKit

open class StandardKeyboardActionHandler: KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(
        inputViewController: UIInputViewController,
        tapHapticFeedback: HapticFeedback = .none,
        longPressHapticFeedback: HapticFeedback = .none) {
        self.inputViewController = inputViewController
        self.tapHapticFeedback = tapHapticFeedback
        self.longPressHapticFeedback = longPressHapticFeedback
    }
    
    
    // MARK: - Dependencies
    
    public weak var inputViewController: UIInputViewController?
    
    
    // MARK: - Properties
    
    private let tapHapticFeedback: HapticFeedback
    private let longPressHapticFeedback: HapticFeedback
    
    public var textDocumentProxy: UITextDocumentProxy? {
        return inputViewController?.textDocumentProxy
    }
    
    
    // MARK: - Action Functions
    
    open func tapAction(for view: UIView, action: KeyboardAction) -> (() -> ())? {
        if let inputAction = action.standardInputViewControllerAction {
            return { inputAction(self.inputViewController) }
        }
        if let proxyAction = action.standardTextDocumentProxyAction {
            return { proxyAction(self.textDocumentProxy) }
        }
        return nil
    }
    
    open func longPressAction(for view: UIView, action: KeyboardAction) -> (() -> ())? {
        return nil
    }
    
    
    // MARK: - Handling Functions
    
    open func handleTap(on action: KeyboardAction, view: UIView) {
        guard let tapAction = tapAction(for: view, action: action) else { return }
        giveHapticFeedbackForTap(on: action)
        tapAction()
    }
    
    open func handleLongPress(on action: KeyboardAction, view: UIView) {
        guard let longPressAction = longPressAction(for: view, action: action) else { return }
        giveHapticFeedbackForLongPress(on: action)
        longPressAction()
    }
    
    
    // MARK: - Haptic Functions
    
    open func giveHapticFeedbackForTap(on action: KeyboardAction) {
        tapHapticFeedback.trigger()
    }
    
    open func giveHapticFeedbackForLongPress(on action: KeyboardAction) {
        longPressHapticFeedback.trigger()
    }
}
