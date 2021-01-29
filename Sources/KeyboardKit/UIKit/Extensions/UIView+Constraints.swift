//
//  UIView+Constraints.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-01-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIView {

    /**
     Remove all constraints that are apolied to the view.
     */
    func removeAllConstraints() {
        var parent = self.superview

        while let superview = parent {
            for constraint in superview.constraints {

                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            parent = superview.superview
        }

        removeConstraints(constraints)
        translatesAutoresizingMaskIntoConstraints = true
    }
}
