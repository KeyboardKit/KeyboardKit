//
//  StandardKeyboardActionHandler+Feedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-02-06.
//

import UIKit

extension StandardKeyboardActionHandler {
    
    @available(*, deprecated, message: "Use configuration-based init instead")
    public convenience init(
        inputViewController: KeyboardInputViewController,
        tapHapticFeedback: HapticFeedback = .none,
        longPressHapticFeedback: HapticFeedback = .none,
        repeatHapticFeedback: HapticFeedback = .none) {
        let hapticConfiguration = HapticFeedbackConfiguration(
            tapFeedback: tapHapticFeedback,
            longPressFeedback: longPressHapticFeedback,
            repeatFeedback: repeatHapticFeedback
        )
        self.init(
            inputViewController: inputViewController,
            hapticConfiguration: hapticConfiguration,
            audioConfiguration: .noFeedback)
        
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
