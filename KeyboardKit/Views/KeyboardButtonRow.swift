//
//  KeyboardButtonRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This row can be setup with actions and a button creator. It
 will populate a horizontal stack view and can be added to a
 keyboard input view controller's main stack view.
 
 */

import UIKit

open class KeyboardButtonRow: UIView, KeyboardStackViewComponent {
    
    
    // MARK: - Initialization
    
    public convenience init(
        height: CGFloat,
        actions: [KeyboardAction],
        distribution: UIStackView.Distribution = .fillEqually,
        buttonCreator: KeyboardButtonCreator) {
        self.init(frame: .zero)
        self.height = height
        self.distribution = distribution
        let buttons = actions.map { buttonCreator($0) }
        buttonStackView.addArrangedSubviews(buttons)
    }
    
    
    // MARK: - Types
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView)
    
    
    // MARK: - Properties
    
    public private(set) var distribution: UIStackView.Distribution = .fillEqually
    
    
    // MARK: - View Properties
    
    public lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = distribution
        addSubview(stackView, fill: true)
        return stackView
    }()
    
    
    // MARK: - KeyboardStackViewComponent
    
    public private(set) lazy var heightConstraint: NSLayoutConstraint = {
        let constraint = heightAnchor.constraint(equalToConstant: 50)
        constraint.isActive = true
        return constraint
    }()
}
