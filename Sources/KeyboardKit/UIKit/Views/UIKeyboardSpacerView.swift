//
//  UIKeyboardSpacerView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-07.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This view can be used as a horizontal space in a button row.
 
 You could for instance map `.none` actions to this view, to
 let you declare "spaces" in your action collections.
 */
open class UIKeyboardSpacerView: UIView, UIKeyboardButtonRowComponent {
    
    public convenience init(width: CGFloat) {
        self.init(frame: .zero)
        self.width = width
        backgroundColor = .clearInteractable
    }
    
    public var widthConstraint: NSLayoutConstraint?
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: width, height: size.height)
    }
}
