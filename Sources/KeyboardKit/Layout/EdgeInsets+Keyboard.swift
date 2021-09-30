//
//  EdgeInsets+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension EdgeInsets {
    
    /**
     The standard edge insets of a system keyboard button in
     a native keyboard.
     */
    static func standardKeyboardButtonInsets(
        for device: UIDevice = .current,
        vc: KeyboardInputViewController = .shared) -> EdgeInsets {
        standardKeyboardButtonInsets(
            for: device.userInterfaceIdiom,
               orientation: vc.screenOrientation)
    }
    
    /**
     This internal function is used by the unit test project.
     */
    static func standardKeyboardButtonInsets(
        for idiom: UIUserInterfaceIdiom,
        orientation: UIInterfaceOrientation) -> EdgeInsets {
        orientation.isLandscape
            ? idiom == .pad ? .horizontal(7, vertical: 6) : .horizontal(3, vertical: 4)
            : idiom == .pad ? .horizontal(6, vertical: 6) : .horizontal(3, vertical: 6)
    }
}
