//
//  KeyboardButtonView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This button implements `KeyboardButton` and also provides a
 setup function that sets the button up properly.
 
 */

import UIKit

open class KeyboardButtonView: UIButton, KeyboardButton {
    
    public private(set) var action: KeyboardAction = .none
    public private(set) var keyboardAppearance: UIKeyboardAppearance = .default
    public var widthConstraint: NSLayoutConstraint?
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: width, height: size.height)
    }
    
    open func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController) {
        self.action = action
        self.keyboardAppearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
        viewController.addKeyboardGestures(to: self)
    }
}
