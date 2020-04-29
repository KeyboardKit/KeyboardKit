//
//  UIView+Gestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-04-29.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIView {

    /**
     This function is used internally to remove all gestures
     from a view.
     */
    func removeAllGestureRecognizers() {
        gestureRecognizers?.forEach { removeGestureRecognizer($0) }
    }
}
