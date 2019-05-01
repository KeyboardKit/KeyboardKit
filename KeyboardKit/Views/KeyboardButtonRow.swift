//
//  KeyboardButtonRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

open class KeyboardButtonRow: UIView, KeyboardStackViewComponent {
    
    
    // MARK: - Initialization
    
    public convenience init(height: CGFloat) {
        self.init(frame: .zero)
        self.height = height
    }
    
    
    // MARK: - Setup
    
    open func setup(with actions: [KeyboardAction], buttonCreator: KeyboardButtonCreator) {
        removeAllButtons()
        let buttons = actions.map {buttonCreator($0) }
        buttons.forEach { buttonStackView.addArrangedSubview($0) }
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
    
    open func removeAllButtons() {
        buttonStackView.arrangedSubviews.forEach {
            buttonStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
