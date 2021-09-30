//
//  UIEdgeInsets+Insets.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit
import SwiftUI

public extension EdgeInsets {
    
    /**
     Create an `EdgeInsets` with the same insets everywhere.
     */
    static func all(_ all: CGFloat) -> EdgeInsets {
        self.init(top: all, leading: all, bottom: all, trailing: all)
    }
    
    /**
     Create an `EdgeInsets` with horizontal/vertical values.
     */
    static func horizontal(_ horizontal: CGFloat, vertical: CGFloat) -> EdgeInsets {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    /**
     Create `EdgeInsets` from a `UIEdgeInsets` instance.
     */
    init(insets: UIEdgeInsets) {
        self.init(
            top: insets.top,
            leading: insets.left,
            bottom: insets.bottom,
            trailing: insets.right)
    }
}
