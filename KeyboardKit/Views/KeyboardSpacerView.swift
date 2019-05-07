//
//  KeyboardSpacerView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-07.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This view can be used to add horizontal spacing in a button
 row. For instance, you can map `.none` keyboard action to a
 spacer view, so that you can declare spacing in your action
 collection as well.
 
 */

import UIKit

open class KeyboardSpacerView: UIView, KeyboardButtonRowComponent {
    
    public var widthConstraint: NSLayoutConstraint?
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: width, height: size.height)
    }
}
