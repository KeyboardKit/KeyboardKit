//
//  AutocompleteBugFixTimer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-18.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This timer class is a hack that helps fixing an assumed iOS
 bug that causes `textWillChange` and `textDidChange` to not
 be called when a user types and/or text is sent to the text
 document proxy.
 
 If you are using autocomplete features in a custom keyboard,
 you should create an intance of this timer in `viewDidLoad`.
 It will make the text document proxy update itself properly,
 by adjusting the cursor position using a timer.
 
 The timer will tick once every second (with optional custom
 parameter values) and first adjust the text cursor position
 one step either back or forth, depending on the text cursor
 position. It then triggers a reverse position adjustment to
 make this change almost unnotable. These adjustments causes
 the text document proxy to be correctly updated. However, I
 hope that I find a way to make this hack obsolete.
 
 `IMPORTANT` Using an ugly hack to solve this problem is not
 preferable, but it's the only one I've found to work. Since
 this hack will cause the text cursor to move back and forth,
 albeit with a minimal delay, there's a tiny risk that users
 type during an adjustment, which would cause the text to be
 incorrectly inserted. This fix will also cause text callout
 bubbles to dismiss.
 
 Related issues:
 https://github.com/danielsaidi/KeyboardKit/issues/26
 
 Further reading:
 https://feedbackassistant.apple.com/feedback/6710453
 https://stackoverflow.com/questions/57079057/uiinputviewcontroller-textwillchange-and-textdidchange-are-not-called-when-typin
 */
public class AutocompleteBugFixTimer {

    public init(
        viewController: UIInputViewController,
        tickInterval: TimeInterval = 1,
        reversalInterval: TimeInterval = 0.0001) {
        self.viewController = viewController
        self.timer = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true) { [weak self] _ in
            self?.handleTimerTick(withReversalInterval: reversalInterval)
        }
    }
    
    deinit {
        timer.invalidate()
    }
    
    private unowned var viewController: UIInputViewController
    private var timer: Timer!
}


// MARK: - Internal Properties

extension AutocompleteBugFixTimer {
    
    var hasSelectedText: Bool {
        return proxy.selectedText != nil
    }
    
    var hasTextAfterTextInputCursorPosition: Bool {
        return proxy.documentContextAfterInput != nil
    }
    
    var proxy: UITextDocumentProxy {
        return viewController.textDocumentProxy
    }
    
    var shouldHandleTimerTick: Bool {
        if hasSelectedText { return false }
        return true
    }
}


// MARK: - Internal Functions

extension AutocompleteBugFixTimer {
    
    func handleTimerTick(withReversalInterval interval: TimeInterval) {
        guard shouldHandleTimerTick else { return }
        let offset = hasTextAfterTextInputCursorPosition ? 1 : -1
        proxy.adjustTextPosition(byCharacterOffset: offset)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.proxy.adjustTextPosition(byCharacterOffset: -offset)
        }
    }
}
