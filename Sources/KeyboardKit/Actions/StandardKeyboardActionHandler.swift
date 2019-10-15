//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This action handler is used by default, if you do not apply
 a custom handler by setting the `actionHandler` property on
 your `KeyboardInputViewController` instance.
 
 This handler uses the default actions when keyboard actions
 are tapped, long pressed or repeated. It can be adjusted by
 creating a subclass of this action handler and override the
 `xAction(for:)` and `handleX(on:)` functions.
 
 You can enable haptic feedback by providing haptic feedback
 types for taps and long presses when you create an instance
 of this class. You can also adjust the standard behavior by
 overriding the two `giveHapticFeedbackForX()` functions.
 
 **IMPORTANT** This class must inherit `NSObject` to be able
 to set itself as a selection target, e.g. when saving image
 assets to the photo album.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(
        inputViewController: UIInputViewController,
        hapticConfiguration: HapticFeedbackConfiguration = .noFeedback) {
        self.inputViewController = inputViewController
        self.hapticConfiguration = hapticConfiguration
    }
    
    @available(*, deprecated, message: "Use configuration-based init instead")
    public init(
        inputViewController: UIInputViewController,
        tapHapticFeedback: HapticFeedback = .none,
        longPressHapticFeedback: HapticFeedback = .none,
        repeatHapticFeedback: HapticFeedback = .none) {
        self.inputViewController = inputViewController
        self.hapticConfiguration = HapticFeedbackConfiguration(
            tapFeedback: tapHapticFeedback,
            longPressFeedback: longPressHapticFeedback,
            repeatFeedback: repeatHapticFeedback
        )
    }
    
    
    // MARK: - Dependencies
    
    public private(set) weak var inputViewController: UIInputViewController?
    
    
    // MARK: - Properties
    
    private let hapticConfiguration: HapticFeedbackConfiguration
    
    public var textDocumentProxy: UITextDocumentProxy? {
        return inputViewController?.textDocumentProxy
    }
    
    
    // MARK: - Types
    
    public typealias GestureAction = (() -> Void)
    
    
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
        hapticConfiguration.longPressFeedback.trigger()
    }
    
    open func giveHapticFeedbackForRepeat(on action: KeyboardAction) {
        hapticConfiguration.repeatFeedback.trigger()
    }
    
    open func giveHapticFeedbackForTap(on action: KeyboardAction) {
        hapticConfiguration.tapFeedback.trigger()
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
