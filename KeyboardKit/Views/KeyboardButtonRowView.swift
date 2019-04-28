//
//  KeyboardButtonRowView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

open class KeyboardButtonRowView: UIView {
    
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
    
    public lazy var heightConstraint: NSLayoutConstraint = {
        let constraint = heightAnchor.constraint(equalToConstant: 100)
        constraint.isActive = true
        return constraint
    }()
}
