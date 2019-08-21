//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This action handler is used by the `KeyboardViewController`
 class by default, but can be replaced with any handler that
 implements `KeyboardActionHandler`.
 
 This action handler uses the default action blocks for each
 keyboard action, if any. You can adjust this by subclassing
 and overriding `tapAction(for:)` and `longPressAction(for:)`
 as well as `handleTap(on:)` and `handleLongPress(on:)`. You
 also have the same options for repeat gestures, when a user
 taps and holds on a button. This class only uses the repeat
 action when the user taps `backspace`.
 
 You can enable haptic feedback by providing haptic feedback
 types for taps and long presses when you create an instance
 of this class. You can also adjust the standard behavior by
 overriding the two `giveHapticFeedback` functions.
 
 IMPORTANT: This class must inherit from `NSObject` in order
 to be able to set itself as the selection target, e.g. when
 saving images to the photo album.
 
 */

import UIKit

open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(
        inputViewController: UIInputViewController,
        tapHapticFeedback: HapticFeedback = .none,
        longPressHapticFeedback: HapticFeedback = .none,
        repeatHapticFeedback: HapticFeedback = .none) {
        self.inputViewController = inputViewController
        self.tapHapticFeedback = tapHapticFeedback
        self.longPressHapticFeedback = longPressHapticFeedback
        self.repeatHapticFeedback = repeatHapticFeedback
    }
    
    
    // MARK: - Dependencies
    
    public private(set) weak var inputViewController: UIInputViewController?
    
    
    // MARK: - Properties
    
    private let longPressHapticFeedback: HapticFeedback
    private let tapHapticFeedback: HapticFeedback
    private let repeatHapticFeedback: HapticFeedback
    
    public var textDocumentProxy: UITextDocumentProxy? {
        return inputViewController?.textDocumentProxy
    }
    
    
    // MARK: - Types
    
    public typealias GestureAction = (() -> ())
    
    
    // MARK: - Actions
    
    open func longPressAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        return tapAction(for: action, view: view)
    }
    
    open func repeatAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        guard action == .backspace else { return nil }
        return tapAction(for: action, view: view)
    }
    
    open func tapAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        return inputViewControllerAction(for: action)
            ?? textDocumentProxyAction(for: action)
    }
    
    
    // MARK: - Action Handling
    
    open func handleLongPress(on action: KeyboardAction, view: UIView) {
        guard let longPressAction = longPressAction(for: action, view: view) else { return }
        giveHapticFeedbackForLongPress(on: action)
        longPressAction()
    }
    
    open func handleRepeat(on action: KeyboardAction, view: UIView) {
        guard let repeatAction = repeatAction(for: action, view: view) else { return }
        giveHapticFeedbackForRepeat(on: action)
        repeatAction()
    }
    
    open func handleTap(on action: KeyboardAction, view: UIView) {
        guard let tapAction = tapAction(for: action, view: view) else { return }
        giveHapticFeedbackForTap(on: action)
        tapAction()
    }
    
    
    // MARK: - Haptic Functions
    
    open func giveHapticFeedbackForLongPress(on action: KeyboardAction) {
        longPressHapticFeedback.trigger()
    }
    
    open func giveHapticFeedbackForRepeat(on action: KeyboardAction) {
        repeatHapticFeedback.trigger()
    }
    
    open func giveHapticFeedbackForTap(on action: KeyboardAction) {
        tapHapticFeedback.trigger()
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
