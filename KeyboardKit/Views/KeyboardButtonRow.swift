//
//  KeyboardButtonRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This view can be created with a set of actions and a button
 creation block, which it uses to create and add buttons for
 each provided action to a horizontal `buttonStackView`. The
 button row can be added to the `KeyboardInputViewController`
 `keyboardStackView`.
 
 */

import UIKit

open class KeyboardButtonRow: UIView, KeyboardStackViewComponent {
    
    public convenience init(
        height: CGFloat = .standardKeyboardRowHeight,
        actions: KeyboardActionRow,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually,
        buttonCreator: KeyboardButtonCreator) {
        self.init(frame: .zero)
        self.height = height
        buttonStackView.alignment = alignment
        buttonStackView.distribution = distribution
        let buttons = actions.map { buttonCreator($0) }
        buttonStackView.addArrangedSubviews(buttons)
    }
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView)
    
    public var heightConstraint: NSLayoutConstraint?
    
    public lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        addSubview(stackView, fill: true)
        return stackView
    }()
}
