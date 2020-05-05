//
//  KeyboardInputViewController+Deprecated.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//

import Foundation

extension KeyboardInputViewController {
    
    @available(*, deprecated, renamed: "addNextKeyboardGesture")
    func addSwitchKeyboardGesture(to button: KeyboardButton) {
        addNextKeyboardGesture(to: button)
    }
}
