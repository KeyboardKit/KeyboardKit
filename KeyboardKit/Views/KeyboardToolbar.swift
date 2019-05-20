//
//  KeyboardToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This view resembles the `KeyboardButtonRow` view class, but
 is just created with a certain height. You can then use the
 `stackView` to populate the toolbar with any views you like
 to use. Unlike the `KeyboardButtonRow`, this class does not
 focus on keyboard actions, so you can add anything to it.
 
 */

import UIKit

open class KeyboardToolbar: UIView, KeyboardStackViewComponent {
    
    public convenience init(
        height: CGFloat,
        actions: KeyboardActionRow,
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
