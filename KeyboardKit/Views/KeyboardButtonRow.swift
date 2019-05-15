//
//  KeyboardButtonRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This view can be created with a set of actions and a button
 creator block. It creates and adds a button for each action
 to a horizontal `buttonStackView`. This stack view can then
 be added to the `KeyboardInputViewController`'s stack view.
 
 */

import UIKit

open class KeyboardButtonRow: UIView, KeyboardStackViewComponent {
    
    public convenience init(
        height: CGFloat,
        actions: [KeyboardAction],
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
