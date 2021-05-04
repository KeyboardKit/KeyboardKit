//
//  EdgeInsets+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import UIKit

public extension EdgeInsets {
    
    /**
     The standard edge insets of a system keyboard button in
     a native keyboard.
     
     Thes insets should be INSIDE every button, to provide a
     fake, visual space between buttons. Having a real space
     between the buttons would cause dead tap areas.
     */
    static func standardKeyboardButtonInsets(
        for device: UIDevice = .current,
        app: UIApplication = .shared) -> EdgeInsets {
        EdgeInsets(insets: .standardKeyboardButtonInsets(for: device, app: app))
    }
}

public extension UIEdgeInsets {
    
    /**
     The standard edge insets of a system keyboard button in
     a native keyboard.
     
     Thes insets should be INSIDE every button, to provide a
     fake, visual space between buttons. Having a real space
     between the buttons would cause dead tap areas.
     */
    static func standardKeyboardButtonInsets(
        for device: UIDevice = .current,
        app: UIApplication = .shared) -> UIEdgeInsets {
        standardKeyboardButtonInsets(
            for: device.userInterfaceIdiom,
            orientation: app.statusBarOrientation)
            // orientation: app.preferredKeyboardInterfaceOrientation)
            // 👆 This was an attempt to remove statusBarOrientation usage, but it doesn't work.
    }
}

extension UIEdgeInsets {
    
    /**
     This internal function is used by the unit test project.
     */
    static func standardKeyboardButtonInsets(
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
