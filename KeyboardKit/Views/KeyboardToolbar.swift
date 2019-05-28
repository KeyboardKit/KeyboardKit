//
//  KeyboardToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This class behaves like `KeyboardButtonRow`, but instead of
 providing it with actions and a button creation block, this
 class lets you add any views you like to its `stackView`.
 
 */

import UIKit

open class KeyboardToolbar: UIView, KeyboardStackViewComponent {
    
    public convenience init(
        height: CGFloat,
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
