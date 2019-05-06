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
 another one.
 
 This action handler handles all keyboard actions except the
 `.image` action, which you must handle manually since there
 is no way to send images to the text proxy.
 
 You can adjust how this class handles taps and long presses
 on keyboard actions, by overriding the `handleTap(on:)` and
 `handleLongPress(on:)` functions. You can also override the
 `tapAction(for:)` and `longPressAction(for:)` to completely
 change which action blocks to return for a keyboard action.
 
 You can enable haptic feedback by providing different types
 of haptic feedback for taps and long presses. To change the
 haptic feedback for a specific action, you can override the
 `giveHapticFeedbackForTap/LongPress(on:)` functions as well.
 
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
    
    
    // MARK: - Functions
    
    open func handleLongPress(on view: UIView, action: KeyboardAction) {
        guard let longPressAction = longPressAction(for: view, action: action) else { return }
        giveHapticFeedbackForLongPress(on: action)
        longPressAction()
    }
    
    open func handleTap(on view: UIView, action: KeyboardAction) {
        guard let tapAction = tapAction(for: view, action: action) else { return }
        giveHapticFeedbackForTap(on: action)
        tapAction()
    }
    
    open func giveHapticFeedbackForLongPress(on action: KeyboardAction) {
        longPressHapticFeedback.trigger()
    }
    
    open func giveHapticFeedbackForTap(on action: KeyboardAction) {
        tapHapticFeedback.trigger()
    }
    
    open func longPressAction(for view: UIView, action: KeyboardAction) -> (() -> ())? {
        return nil
    }
    
    open func tapAction(for view: UIView, action: KeyboardAction) -> (() -> ())? {
        switch action {
        case .none: return nil
        case .backspace: return { [weak self] in self?.textDocumentProxy?.deleteBackward() }
        case .dismissKeyboard: return { [weak self] in self?.inputViewController?.dismissKeyboard() }
        case .character(let char): return { [weak self] in self?.textDocumentProxy?.insertText(char) }
        case .image: return nil
        case .moveCursorBack: return { [weak self] in self?.textDocumentProxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { [weak self] in self?.textDocumentProxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .switchKeyboard: return nil
        case .newLine: return { [weak self] in self?.textDocumentProxy?.insertText("\n") }
        case .shift: return nil
        case .space: return { [weak self] in self?.textDocumentProxy?.insertText(" ") }
        }
    }
}
