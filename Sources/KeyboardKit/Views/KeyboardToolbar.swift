//
//  KeyboardToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 Keyboard toolbars are keyboard rows, that can be added to a
 `KeyboardInputViewController`'s `keyboardStackView`.
 
 This base class can be subclassed to create custom toolbars.
 It has a horizontal stack view, that can be used to contain
 any views you want.
 */
open class KeyboardToolbar: UIView, KeyboardStackViewComponent {
    
    public init(
        height: CGFloat = .standardKeyboardRowHeight,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually) {
        super.init(frame: .zero)
        self.height = height
        stackView.alignment = alignment
        stackView.distribution = distribution
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var heightConstraint: NSLayoutConstraint?
    
    public lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        addSubview(stackView, fill: true)
        return stackView
    }()
}
