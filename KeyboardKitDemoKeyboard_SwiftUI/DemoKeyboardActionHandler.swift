//
//  DemoKeyboardActionHandler.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
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
}
