//
//  UIView+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {
    
    /**
     Setup the view as a "next keyboard" system button. Note
     that if the view is not a `UIButton`, this does nothing.
     */
    func setupAsNextKeyboardButton(in vc: UIInputViewController) {
        guard let button = self as? UIButton else { return }
        vc.setupNextKeyboardButton(button)
    }
}

private extension UIInputViewController {
    
    /**
     Setup any `UIButton` as a "next keyboard" system button.
     */
    func setupNextKeyboardButton(_ button: UIButton) {
        let action = #selector(handleInputModeList(from:with:))
        button.addTarget(self, action: action, for: .allTouchEvents)
    }
}
