//
//  AutocompleteBugFixTimer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-18.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

@available(*, deprecated, message: "Do not use this. Instead, make the action handler refresh autocomplete as the user types.")
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

    
    // MARK: - Internal Properties
    
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

    
    // MARK: - Internal Functions
    
    func handleTimerTick(withReversalInterval interval: TimeInterval) {
        guard shouldHandleTimerTick else { return }
        let offset = hasTextAfterTextInputCursorPosition ? 1 : -1
        proxy.adjustTextPosition(byCharacterOffset: offset)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.proxy.adjustTextPosition(byCharacterOffset: -offset)
        }
    }
}
