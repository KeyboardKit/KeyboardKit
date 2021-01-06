//
//  UIEdgeInsets+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {
    
    /**
     The standard row item insets of a vertical keyboard row
     item in a system keyboard.
     
     The insets should be applied INSIDE every row item view
     to provide fake spaces between items, while keeping the
     entire view tappable. Having a real space between views
     would create dead tap areas.
     
     For a keyboard button, it should thus push in the edges
     of the button body to fit these insets, then apply view
     gestures to its entire body.
     */
    static func standardKeyboardRowItemInsets(
        for device: UIDevice = .current,
        app: UIApplication = .shared) -> UIEdgeInsets {
        standardKeyboardRowItemInsets(
            for: device.userInterfaceIdiom,
            orientation: app.statusBarOrientation)
    }
}

extension UIEdgeInsets {
    
    /**
     This internal function is used by the unit test project.
     */
    static func standardKeyboardRowItemInsets(
        for idiom: UIUserInterfaceIdiom,
        orientation: UIInterfaceOrientation) -> UIEdgeInsets {
        orientation.isLandscape
            ? idiom == .pad ? .horizontal(7, vertical: 6) : .horizontal(3, vertical: 4)
            : idiom == .pad ? .horizontal(6, vertical: 4.5) : .horizontal(3, vertical: 6)
    }
}

private extension UIEdgeInsets {
    
    static func all(_ all: CGFloat) -> UIEdgeInsets {
        self.init(top: all, left: all, bottom: all, right: all)
    }
    
    static func horizontal(_ horizontal: CGFloat, vertical: CGFloat) -> UIEdgeInsets {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
