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
    
    public init(rowHeight: CGFloat) {
        super.init(frame: .zero)
        heightConstraint.constant = rowHeight
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        heightConstraint.constant = frame.height
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        heightConstraint.constant = 50
    }
    
    
    // MARK: - Setup
    
    open func setup(with actions: [KeyboardAction], actionHandler: KeyboardActionHandler, buttonCreator: KeyboardButtonCreator) {
        removeAllButtons()
        addButtons(with: actions, actionHandler: actionHandler, buttonCreator: buttonCreator)
    }
    
    
    // MARK: - Types
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView)
    
    
    // MARK: - KeyboardComponent
    
    public lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView, fill: true)
        return stackView
    }()
    
    public lazy var heightConstraint: NSLayoutConstraint = {
        let constraint = heightAnchor.constraint(equalToConstant: 50)
        constraint.isActive = true
        return constraint
    }()
    
    
    // MARK: - Open Functions
    
    open func addButtons(with actions: [KeyboardAction], actionHandler: KeyboardActionHandler, buttonCreator: KeyboardButtonCreator) {
        actions.forEach {
            let button = buttonCreator($0)
            actionHandler.addTapGesture(for: $0, to: button)
            actionHandler.addLongPressGesture(for: $0, to: button)
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    open func removeAllButtons() {
        buttonStackView.arrangedSubviews.forEach {
            buttonStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
