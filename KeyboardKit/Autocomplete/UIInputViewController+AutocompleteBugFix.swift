//
//  UIInputViewController+AutocompleteBugFix.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-18.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/**
 
 
 */

import UIKit

public extension UIInputViewController {
    
    /**
     
     This function is an ugly hack that helps fixing the iOS
     bug that causes `textWillChange` and `textDidChange` to
     not be called when a user types and text is sent to the
     text document proxy. You should call it in `viewDidLoad`
     whenever you use autocomplete providers that should use
     the currently typed or selected word. Make sure to keep
     a strong reference to the created timer.
     
     The timer will tick once every second, and first adjust
     the text cursor position one step either back or forth,
     depending on the text cursor position. It then triggers
     a reverse position adjustment. These adjustments causes
     the text document proxy to be correctly updated, but it
     would be a **lot** better if this hack wasn't required.
     
     **IMPORTANT** Using this hack to solve the autocomplete
     problems is *not* preferable, but it's the only solution
     that I've found so far. Since this hack will cause the
     text input cursor to move back and forth, albeit with a
     very small time delay between the two adjustments, there
     is a tiny risk that the user types in the middle of the
     adjustment process, which will cause her/his text to be
     inserted at an incorrect position.
     
     Further reading:
     https://feedbackassistant.apple.com/feedback/6710453
     https://stackoverflow.com/questions/57079057/uiinputviewcontroller-textwillchange-and-textdidchange-are-not-called-when-typin
     
    */
    func createAutocompleteBugFixTimer(
        withTickInterval interval: TimeInterval = 1,
        reversalInterval: TimeInterval = 0.0001) -> Timer {
        return Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.handleTimerTick(withReversalInterval: reversalInterval)
        }
    }
}

private extension UIInputViewController {
    
    var hasTextAfterTextInputCursorPosition: Bool {
        return textDocumentProxy.documentContextAfterInput != nil
    }
    
    func handleTimerTick(withReversalInterval interval: TimeInterval) {
        let proxy = textDocumentProxy
        let offset = hasTextAfterTextInputCursorPosition ? 1 : -1
        proxy.adjustTextPosition(byCharacterOffset: offset)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            proxy.adjustTextPosition(byCharacterOffset: -offset)
        }
    }
}
