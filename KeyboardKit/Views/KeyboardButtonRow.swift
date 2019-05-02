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
    
    public convenience init(height: CGFloat, actions: [KeyboardAction], buttonCreator: KeyboardButtonCreator) {
        self.init(frame: .zero)
        self.height = height
        addButtons(with: actions, buttonCreator: buttonCreator)
    }
    
    
    // MARK: - Types
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView)
    
    
    // MARK: - View Properties
    
    public lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView, fill: true)
        return stackView
    }()
    
    
    // MARK: - KeyboardStackViewComponent
    
    public lazy var heightConstraint: NSLayoutConstraint = {
        let constraint = heightAnchor.constraint(equalToConstant: 50)
        constraint.isActive = true
        return constraint
    }()
    
    
    // MARK: - Functions
    
    open func addButtons(with actions: [KeyboardAction], buttonCreator: KeyboardButtonCreator) {
        let buttons = actions.map {buttonCreator($0) }
        buttons.forEach { buttonStackView.addArrangedSubview($0) }
    }
    
    open func removeAllButtons() {
        buttonStackView.arrangedSubviews.forEach {
            buttonStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
