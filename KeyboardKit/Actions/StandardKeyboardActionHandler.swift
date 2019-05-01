//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This action handler is used by default by all keyboard view
 controllers if you don't explicitly provide another one. It
 only inherits `NSObject` to make it possible for subclasses
 to act as selector targets.
 
 `StandardKeyboardActionHandler` handles all actions, except
 `.image`, which you must handle manually, since there is no
 way to send images to the text proxy.
 
 You can adjust tap and long press action handling by either
 overriding `tapAction(for:)` and `longPressAction(for:)` to
 return other action blocks or by overriding `handleTap(on:)`
 and `handleLongPress(on:)`.
 
 You can adjust the haptic feedback given by this handler by
 either providing different tap and longpress feedback types
 in `init`, or by overriding `giveHapticFeedbackForTap(on:)`
 and `giveHapticFeedbackForLongPress(on:)`.
 
 */

import UIKit

open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    public init(
        inputViewController: UIInputViewController,
        tapHapticFeedback: HapticFeedback = .none,
        longPressHapticFeedback: HapticFeedback = .none) {
        self.inputViewController = inputViewController
        self.tapHapticFeedback = tapHapticFeedback
        self.longPressHapticFeedback = longPressHapticFeedback
    }
    
    
    public weak var inputViewController: UIInputViewController?
    
    private let tapHapticFeedback: HapticFeedback
    private let longPressHapticFeedback: HapticFeedback
    
    public var textDocumentProxy: UITextDocumentProxy? {
        return inputViewController?.textDocumentProxy
    }
    
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
        case .character(let char): return { [weak self] in self?.textDocumentProxy?.insertText(char) }
        case .image: return nil
        case .moveCursorBack: return { [weak self] in self?.textDocumentProxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { [weak self] in self?.textDocumentProxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .switchKeyboard: return nil// { [weak self] in self?.inputViewController?.advanceToNextInputMode() }
        case .newLine: return { [weak self] in self?.textDocumentProxy?.insertText("\n") }
        case .shift: return nil
        case .space: return { [weak self] in self?.textDocumentProxy?.insertText(" ") }
        }
    }
}
