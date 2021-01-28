//
//  KeyboardButtonView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class implements `KeyboardButton` and can be used as a
 base class for your app's keyboard buttons.
 */
open class KeyboardButtonView: UIButton, KeyboardButton {
    
    public private(set) var action: KeyboardAction = .none
    public private(set) var secondaryAction: KeyboardAction?
    public private(set) var keyboardAppearance: UIKeyboardAppearance = .default
    
    public var widthConstraint: NSLayoutConstraint?
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: width, height: size.height)
    }
    
    open func setup(
        with action: KeyboardAction,
        secondaryAction: KeyboardAction? = nil,
        in viewController: KeyboardInputViewController) {
        self.action = action
        self.secondaryAction = secondaryAction
        self.keyboardAppearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
        self.addKeyboardGestures(in: viewController)
    }
}
