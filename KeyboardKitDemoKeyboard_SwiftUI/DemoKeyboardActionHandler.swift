//
//  DemoKeyboardActionHandler.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import KeyboardKitSwiftUI
import UIKit

/**
 This action handler inherits `DemoKeyboardActionHandlerBase`
 and adds `SwiftUI` demo-specific functionality to it.
 */
class DemoKeyboardActionHandler: DemoKeyboardActionHandlerBase {
    
    public init(inputViewController: KeyboardViewController, toastContext: KeyboardToastContext) {
        self.toastContext = toastContext
        super.init(inputViewController: inputViewController)
    }
    
    private let toastContext: KeyboardToastContext
    
    override func alert(_ message: String) {
        toastContext.present(message)
    }
    
    override func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        switch action {
        case .emojiCategory(let category): inputViewController?.context.emojiCategory = category
        default: super.handle(gesture, on: action, sender: sender)
        }
    }
}
