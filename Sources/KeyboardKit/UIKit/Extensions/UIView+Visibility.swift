//
//  UIView+Visibility.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-12-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIView {

    var isVisible: Bool {
        get { !isHidden }
        set { isHidden = !newValue }
    }
    
    func hide() {
        isHidden = true
    }
    
    func show() {
        isVisible = true
    }
}
