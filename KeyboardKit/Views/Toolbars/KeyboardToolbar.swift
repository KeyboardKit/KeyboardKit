//
//  KeyboardToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 Keyboard toolbars are "toolbar rows" that can be added to a
 `KeyboardInputViewController`s `keyboardStackView`.
 
 This is a base class, that you can inherit to create custom
 toolbars. It has a horizontal `stackView`, to which you can
 add any views you like.
 
 */

import UIKit

open class KeyboardToolbar: UIView, KeyboardStackViewComponent {
    
    public convenience init(
        height: CGFloat = .standardKeyboardRowHeight,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually) {
        self.init(frame: .zero)
        self.height = height
        stackView.alignment = alignment
        stackView.distribution = distribution
    }
    
    public var heightConstraint: NSLayoutConstraint?
    
    public lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        addSubview(stackView, fill: true)
        return stackView
    }()
}
