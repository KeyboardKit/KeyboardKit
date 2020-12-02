//
//  KeyboardToolbarView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 Keyboard toolbars are vertical rows, that can be added to a
 `KeyboardInputViewController`'s `keyboardStackView`.
 
 You can subclassed this class to create custom toolbars. It
 has a horizontal stack view that can be used to contain any
 views that you want the toolbar to present.
 */
open class KeyboardToolbarView: UIView, KeyboardStackViewComponent {
    
    public init(
        height: CGFloat = standardHeight(),
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
